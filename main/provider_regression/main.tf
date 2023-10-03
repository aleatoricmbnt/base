terraform {
  required_providers {
    scalr = {
      source = "Scalr/scalr"
      version = "1.4.0"
    }
  }
}

resource "scalr_environment" "env" {
  name                    = "env_${formatdate("DDMMYYYY", timestamp())}"
  cost_estimation_enabled = true
  tag_ids                 = [scalr_tag.tg.id]
}

resource "scalr_vcs_provider" "vcs" {
  name     = "vcs_${formatdate("DDMMYYYY", timestamp())}"
  vcs_type = "github"
  token    = var.github_vcs_token
}

resource "scalr_policy_group" "pg" {
  name            = "pg_${formatdate("DDMMYYYY", timestamp())}"
  opa_version     = var.opa_version
  vcs_provider_id = scalr_vcs_provider.vcs.id
  vcs_repo {
    identifier = var.pg_vcs-repo_identifier
    path       = var.pg_vcs-repo_path
    branch     = var.pg_vcs-repo_branch
  }
}

resource "scalr_policy_group_linkage" "pg_link" {
  policy_group_id = scalr_policy_group.pg.id
  environment_id  = scalr_environment.env.id
}

resource "scalr_endpoint" "ep" {
  name           = "endpoint_${formatdate("DDMMYYYY", timestamp())}"
  secret_key     = "A3a44119946b537bcd94ec64b14e4e3196bcf6867"
  timeout        = 15
  max_attempts   = 3
  url            = var.ep_url
  environment_id = scalr_environment.env.id
}

resource "scalr_webhook" "wh" {
  name           = "wh_${formatdate("DDMMYYYY", timestamp())}"
  enabled        = true
  endpoint_id    = scalr_endpoint.ep.id
  events         = ["run:completed", "run:errored", "run:needs_attention"]
  environment_id = scalr_environment.env.id
}

resource "scalr_tag" "tg" {
  name = "provider_regression:${formatdate("DDMMYYYY", timestamp())}"
}

resource "scalr_module" "mod" {
  environment_id  = scalr_environment.env.id
  vcs_provider_id = scalr_vcs_provider.vcs.id
  vcs_repo {
    identifier = var.mod_vcs-repo_identifier
    path       = var.mod_vcs-repo_path
    tag_prefix = var.mod_vcs-repo_tag-prefix
  }
}

resource "scalr_provider_configuration" "pcfg_gcp" {
  name         = "pcfg_gcp_${formatdate("DDMMYYYY", timestamp())}"
  environments = [scalr_environment.env.id]
  google {
    credentials = var.pcfg_gcp_credentials
  }
}

resource "scalr_provider_configuration_default" "pcfg-default" {
  environment_id            = scalr_environment.env.id
  provider_configuration_id = scalr_provider_configuration.pcfg_gcp.id
}

resource "scalr_variable" "var_env" {
  key            = "TF_LOG"
  value          = "TRACE"
  category       = "shell"
  environment_id = scalr_environment.env.id
}

resource "scalr_workspace" "ws_vcs" {
  name            = "ws_vcs_${formatdate("DDMMYYYY", timestamp())}"
  environment_id  = scalr_environment.env.id
  vcs_provider_id = scalr_vcs_provider.vcs.id

  working_directory = var.ws-vcs_workdir

  vcs_repo {
    identifier = var.ws-vcs_vcs-repo_identifier
    branch     = var.ws-vcs_vcs-repo_branch
  }

  tag_ids = [scalr_tag.tg.id]
}

resource "scalr_workspace" "ws_cli" {
  name           = "ws_cli_${formatdate("DDMMYYYY", timestamp())}"
  environment_id = scalr_environment.env.id
  agent_pool_id  = scalr_agent_pool.ap.id
}

resource "scalr_workspace_run_schedule" "run-schedule" {
  workspace_id   = scalr_workspace.ws_vcs.id
  apply_schedule = "* * * * *"
}

resource "scalr_run_trigger" "run-trigger" {
  downstream_id = scalr_workspace.ws_vcs.id # run automatically triggered in this workspace once the run in the upstream workspace is applied
  upstream_id   = scalr_workspace.ws_cli.id
}

resource "scalr_service_account" "sa" {
  name   = "sa-${formatdate("DDMMYYYY", timestamp())}"
  status = "Active"
}

resource "scalr_agent_pool" "ap" {
  name = "ap_${formatdate("DDMMYYYY", timestamp())}"
}

resource "scalr_agent_pool_token" "ap-token" {
  description   = "Provider regression. Date: ${timestamp()}"
  agent_pool_id = scalr_agent_pool.ap.id
}

resource "scalr_iam_team" "team" {
  name        = "dev"
  description = "Regression ${formatdate("DDMMYYYY", timestamp())}"
}

resource "scalr_role" "role" {
  name        = "role_${formatdate("DDMMYYYY", timestamp())}"
  description = "Regression: *:* permissions"

  permissions = [
    "*:read",
    "*:update",
    "*:delete",
    "*:create"
  ]
}

resource "scalr_access_policy" "access-policy" {
  subject {
    type = "team"
    id   = scalr_iam_team.team.id
  }
  scope {
    type = "workspace"
    id   = scalr_workspace.ws_vcs.id
  }

  role_ids = [
    scalr_role.role.id
  ]
}


# Commented because couldn't be applied via Scalr, as list should include one of Scalr's IPs so it would pass validation
# resource "scalr_account_allowed_ips" "whitelist" {
#   allowed_ips = [var.my_ip]
# }

data "scalr_access_policy" "data_access-policy" {
  id = scalr_access_policy.access-policy.id
}

output "out_access-policy" {
  value = yamlencode(data.scalr_access_policy.data_access-policy)
}

data "scalr_agent_pool" "data-ap" {
  name = scalr_agent_pool.ap.name
}

output "out-ap" {
  value = yamlencode(data.scalr_agent_pool.data-ap)
}

# data "scalr_current_account" "data_acc" {}

# output "out_acc" {
# value = yamlencode(data.scalr_current_account.data_acc)
# }

# data "scalr_current_run" "data_run" {}

# output "out_run" {
# value = yamlencode(data.scalr_current_run.data_run)
# }

data "scalr_endpoint" "data_ep" {
  id = scalr_endpoint.ep.id
}

output "out_ep" {
  value     = yamlencode(data.scalr_endpoint.data_ep)
  sensitive = true
}

data "scalr_environment" "data_env" {
  name = scalr_environment.env.name
}

output "out_env" {
  value = yamlencode(data.scalr_environment.data_env)
}

data "scalr_iam_team" "data_team" {
  name = scalr_iam_team.team.name
}

output "out_team" {
  value = yamlencode(data.scalr_iam_team.data_team)
}

data "scalr_iam_user" "data_user" {
  email = var.user_email
}

output "out_user" {
  value = yamlencode(data.scalr_iam_user.data_user)
}

data "scalr_module_version" "data_modver" {
  source  = var.modver_source
  version = var.modver_version
}

output "out_modver" {
  value = yamlencode(data.scalr_module_version.data_modver)
}

data "scalr_policy_group" "data_pg" {
  name = scalr_policy_group.pg.name
}

output "out_pg" {
  value = yamlencode(data.scalr_policy_group.data_pg)
}

data "scalr_provider_configuration" "data_pcfg" {
  name = scalr_provider_configuration.pcfg_gcp.name
}

output "out_pcfg" {
  value = yamlencode(data.scalr_provider_configuration.data_pcfg)
}

data "scalr_provider_configurations" "data_pcfgs" {
  name = scalr_provider_configuration.pcfg_gcp.name
}

output "out_pcfgs" {
  value = yamlencode(data.scalr_provider_configurations.data_pcfgs)
}

data "scalr_variables" "data_vars" {
  category = "shell"
}

output "out_vars" {
  value = yamlencode(data.scalr_variables.data_vars)
}

data "scalr_role" "data_role" {
  name = scalr_role.role.name
}

output "out_role" {
  value = yamlencode(data.scalr_role.data_role)
}

data "scalr_service_account" "data_sa" {
  email = scalr_service_account.sa.email
}

output "out_sa" {
  value = yamlencode(data.scalr_service_account.data_sa)
}

data "scalr_tag" "data_tg" {
  name = scalr_tag.tg.name
}

output "out_tg" {
  value = yamlencode(data.scalr_policy_group.data_pg)
}

data "scalr_variable" "data_var" {
  key            = scalr_variable.var_env.key
  environment_id = scalr_environment.env.id
}

output "out_var" {
  value = yamlencode(data.scalr_variable.data_var)
}

data "scalr_vcs_provider" "data_vcs" {
  name = scalr_vcs_provider.vcs.name
}

output "out_vcs" {
  value = yamlencode(data.scalr_vcs_provider.data_vcs)
}

data "scalr_webhook" "data_wh" {
  id = scalr_webhook.wh.id
}

output "out_wh" {
  value = yamlencode(data.scalr_webhook.data_wh)
  sensitive = true
}

data "scalr_workspace" "data_ws" {
  name           = scalr_workspace.ws_vcs.name
  environment_id = scalr_environment.env.id
}

output "out_ws" {
  value = yamlencode(data.scalr_workspace.data_ws)
}

data "scalr_workspace_ids" "data_all-ws" {
  names          = ["*"]
  environment_id = scalr_environment.env.id
}

output "out_all-ws" {
  value = yamlencode(data.scalr_workspace_ids.data_all-ws)
}
