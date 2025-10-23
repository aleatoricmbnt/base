terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-master"
      # version = "3.7.0"
    }
  }
}

data "scalr_current_account" "aleatoric" {}

data "scalr_current_run" "this" {}

# resource "scalr_role" "random_list_of_permissions" {
#   name        = "random_list_of_permissions"
#   description = "Random list of permissions"

#   account_id  = data.scalr_current_account.aleatoric.id

#   permissions = [
#     "*:read",
#     "environments:*"
#     # "*:read"
#   ]
# }

# resource "scalr_access_policy" "team_read_all_on_acc_scope" {
#   subject {
#     type = "user"
#     id   = "user-v0oqqb8a72cc18s8h"
#   }
#   scope {
#     type = "account"
#     id   = data.scalr_current_account.aleatoric.id
#   }

#   role_ids = [
#     "role-v0oaqnip1t4bvkium",
#     scalr_role.random_list_of_permissions.id,
#     scalr_role.random_list_of_permissions.id
#   ]
# }

# resource "scalr_iam_team" "dev" {
#   name        = "dev"
#   description = "Developers"

#   users = ["user-v0o5ai48me2l6658l","user-ucbke9vugfu1sko", "user-v0o5ai48me2l6658l", "user-ucbke9vugfu1sko"]
# }

resource "scalr_policy_group" "example" {
  name            = "something_new"
  opa_version     = "0.70.0"
  vcs_provider_id = "vcs-u7btqoq3uofo540"
  # environments    = ["env-v0oqnl6qi3ue7c0lg", "env-v0ohtvdn9bjltg2fb"]
  vcs_repo {
    identifier = "aleatoricmbnt/base"
    path       = "policies/3_levels_policy"
    branch     = "master"
  }
}

# resource "scalr_webhook" "example1" {
#   name         = "my-webhook-1"
#   enabled      = true
#   url          = "https://my-endpoint.url"
#   secret_key   = "my-secret-key3427895439fGHSDH_"
#   timeout      = 15
#   max_attempts = 3
#   events       = ["run:errored", "run:completed", "run:errored", "run:completed"]
#   environments = ["env-v0oqnl6qi3ue7c0lg", "env-v0ohtvdn9bjltg2fb"]
#   header {
#     name  = "header1"
#     value = "value1"
#   }
#   header {
#     name  = "header2"
#     value = "value2"
#   }
# }

resource "scalr_provider_configuration" "kubernetes" {
  name            = "k8s"
  environments    = ["env-v0oqnl6qi3ue7c0lg", "env-v0ohtvdn9bjltg2fb"]
  custom {
    provider_name = "my-provider-name"
    argument {
      name        = "host"
      value       = "my-host"
      description = "The hostname (in form of URI) of the Kubernetes API."
    }
  }
}