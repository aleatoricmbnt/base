terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "~> 2.0"
    }
  }
}

provider "scalr" {
  # hostname and token will be provided via environment variables
  # SCALR_HOSTNAME and SCALR_TOKEN
}

# Data Sources (testing without account_id)
data "scalr_current_account" "test" {}

data "scalr_current_run" "test" {}

data "scalr_environments" "test" {}

data "scalr_workspaces" "test" {}

data "scalr_workspace_ids" "test" {
  name = "test-workspace"
}

data "scalr_variables" "test" {
  category = "terraform"
}

data "scalr_provider_configurations" "test" {}

# Create foundational resources first
resource "scalr_environment" "test" {
  name        = "test-environment"
  description = "Test environment for account_id deprecation testing"
}

resource "scalr_iam_team" "test" {
  name        = "test-team"
  description = "Test team for account_id deprecation testing"
}

resource "scalr_role" "test" {
  name        = "test-role"
  description = "Test role for account_id deprecation testing"
  permissions = ["*:read"]
}

resource "scalr_service_account" "test" {
  name        = "test-service-account"
  description = "Test service account for account_id deprecation testing"
}

resource "scalr_service_account_token" "test" {
  service_account_id = scalr_service_account.test.id
  description        = "Test token for account_id deprecation testing"
}

resource "scalr_agent_pool" "test" {
  name           = "test-agent-pool"
  environment_id = scalr_environment.test.id
}

resource "scalr_agent_pool_token" "test" {
  agent_pool_id = scalr_agent_pool.test.id
  description   = "Test agent pool token for account_id deprecation testing"
}

resource "scalr_vcs_provider" "test" {
  name         = "test-vcs-provider"
  vcs_type     = "github"
  token        = "dummy-token-for-testing"
  environments = [scalr_environment.test.id]
}

resource "scalr_workspace" "test" {
  name              = "test-workspace"
  environment_id    = scalr_environment.test.id
  terraform_version = "1.5.0"
  working_directory = "/"
  
  vcs_repo {
    identifier = "test/repo"
    branch     = "main"
  }
}

resource "scalr_variable" "test_terraform" {
  key          = "test_terraform_var"
  value        = "test_value"
  category     = "terraform"
  workspace_id = scalr_workspace.test.id
  description  = "Test terraform variable for account_id deprecation testing"
}

resource "scalr_variable" "test_environment" {
  key            = "test_env_var"
  value          = "test_value"
  category       = "env"
  environment_id = scalr_environment.test.id
  description    = "Test environment variable for account_id deprecation testing"
}

resource "scalr_provider_configuration" "test_aws" {
  name           = "test-aws-config"
  environments   = [scalr_environment.test.id]
  provider_name  = "aws"
  
  aws {
    credentials_type = "access_keys"
    access_key       = "dummy-access-key"
    secret_key       = "dummy-secret-key"
  }
}

resource "scalr_provider_configuration_default" "test" {
  provider_configuration_id = scalr_provider_configuration.test_aws.id
  environment_id            = scalr_environment.test.id
}

resource "scalr_ssh_key" "test" {
  name        = "test-ssh-key"
  public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC... test@example.com"
  description = "Test SSH key for account_id deprecation testing"
}

resource "scalr_hook" "test" {
  name           = "test-hook"
  script         = "echo 'test hook'"
  timeout        = 300
  environments   = [scalr_environment.test.id]
}

resource "scalr_environment_hook" "test" {
  hook_id        = scalr_hook.test.id
  environment_id = scalr_environment.test.id
  stage          = "pre_plan"
}

resource "scalr_policy_group" "test" {
  name           = "test-policy-group"
  opa_version    = "0.45.0"
  environments   = [scalr_environment.test.id]
}

resource "scalr_policy_group_linkage" "test" {
  policy_group_id = scalr_policy_group.test.id
  environment_id  = scalr_environment.test.id
}

resource "scalr_access_policy" "test" {
  subject {
    type = "team"
    id   = scalr_iam_team.test.id
  }
  
  scope {
    type = "environment"
    id   = scalr_environment.test.id
  }
  
  role_ids = [scalr_role.test.id]
}

resource "scalr_assume_service_account_policy" "test" {
  subject {
    type = "team"
    id   = scalr_iam_team.test.id
  }
  
  scope {
    type = "environment"
    id   = scalr_environment.test.id
  }
  
  service_account_id = scalr_service_account.test.id
}

resource "scalr_run_trigger" "test" {
  workspace_id    = scalr_workspace.test.id
  upstream_workspace_id = scalr_workspace.test.id
}

resource "scalr_run_schedule_rule" "test" {
  workspace_id = scalr_workspace.test.id
  schedule     = "0 9 * * MON-FRI"
  enabled      = true
}

resource "scalr_workspace_run_schedule" "test" {
  workspace_id = scalr_workspace.test.id
  schedule     = "0 10 * * MON-FRI"
  enabled      = true
}

resource "scalr_tag" "test" {
  name = "test-tag"
}

resource "scalr_module_namespace" "test" {
  name = "test-namespace"
}

resource "scalr_module" "test" {
  name      = "test-module"
  namespace = scalr_module_namespace.test.name
  provider  = "aws"
  
  vcs_repo {
    identifier = "test/terraform-module"
    tag_prefix = "v"
  }
}

resource "scalr_storage_profile" "test" {
  name        = "test-storage-profile"
  type        = "s3"
  
  s3 {
    bucket = "test-terraform-state-bucket"
    region = "us-east-1"
  }
}

resource "scalr_webhook" "test" {
  name        = "test-webhook"
  url         = "https://example.com/webhook"
  enabled     = true
  events      = ["run:completed"]
  environments = [scalr_environment.test.id]
}

resource "scalr_endpoint" "test" {
  name           = "test-endpoint"
  url            = "https://api.example.com"
  timeout        = 30
  max_attempts   = 3
  environments   = [scalr_environment.test.id]
}

resource "scalr_workload_identity_provider" "test" {
  name           = "test-wip"
  environments   = [scalr_environment.test.id]
  
  aws {
    role_arn           = "arn:aws:iam::123456789012:role/TestRole"
    external_id        = "test-external-id"
    session_duration   = 3600
  }
}

# Additional data sources that depend on created resources
data "scalr_environment" "test" {
  name = scalr_environment.test.name
}

data "scalr_workspace" "test" {
  name           = scalr_workspace.test.name
  environment_id = scalr_environment.test.id
}

data "scalr_iam_team" "test" {
  name = scalr_iam_team.test.name
}

data "scalr_iam_user" "test" {
  email = "test@example.com"
}

data "scalr_role" "test" {
  name = scalr_role.test.name
}

data "scalr_service_account" "test" {
  name = scalr_service_account.test.name
}

data "scalr_agent_pool" "test" {
  name           = scalr_agent_pool.test.name
  environment_id = scalr_environment.test.id
}

data "scalr_hook" "test" {
  name = scalr_hook.test.name
}

data "scalr_policy_group" "test" {
  name = scalr_policy_group.test.name
}

data "scalr_provider_configuration" "test" {
  name           = scalr_provider_configuration.test_aws.name
  environment_id = scalr_environment.test.id
}

data "scalr_ssh_key" "test" {
  name = scalr_ssh_key.test.name
}

data "scalr_storage_profile" "test" {
  name = scalr_storage_profile.test.name
}

data "scalr_tag" "test" {
  name = scalr_tag.test.name
}

data "scalr_variable" "test_terraform" {
  key          = scalr_variable.test_terraform.key
  category     = "terraform"
  workspace_id = scalr_workspace.test.id
}

data "scalr_variable" "test_environment" {
  key            = scalr_variable.test_environment.key
  category       = "env"
  environment_id = scalr_environment.test.id
}

data "scalr_vcs_provider" "test" {
  name = scalr_vcs_provider.test.name
}

data "scalr_webhook" "test" {
  name = scalr_webhook.test.name
}

data "scalr_workload_identity_provider" "test" {
  name = scalr_workload_identity_provider.test.name
}

data "scalr_module_version" "test" {
  module_id = scalr_module.test.id
  version   = "1.0.0"
}

data "scalr_module_versions" "test" {
  module_id = scalr_module.test.id
}

data "scalr_access_policy" "test" {
  id = scalr_access_policy.test.id
}

data "scalr_assume_service_account_policy" "test" {
  id = scalr_assume_service_account_policy.test.id
}

data "scalr_endpoint" "test" {
  name = scalr_endpoint.test.name
}

# Conditional resources that might need specific integrations
# These are commented out as they require external service configurations

# resource "scalr_event_bridge_integration" "test" {
#   name              = "test-eventbridge"
#   environment_id    = scalr_environment.test.id
#   aws_account_id    = "123456789012"
#   aws_region        = "us-east-1"
# }

# resource "scalr_integration_infracost" "test" {
#   api_key = "dummy-infracost-api-key"
# }

# resource "scalr_slack_integration" "test" {
#   name           = "test-slack"
#   bot_token      = "xoxb-dummy-token"
#   environments   = [scalr_environment.test.id]
# }

# Data sources for conditional resources
# data "scalr_event_bridge_integration" "test" {
#   name = "test-eventbridge"
# }

# data "scalr_integration_infracost" "test" {}

# Output some key information for verification
output "environment_id" {
  value = scalr_environment.test.id
}

output "workspace_id" {
  value = scalr_workspace.test.id
}

output "current_account_id" {
  value = data.scalr_current_account.test.id
}

output "test_summary" {
  value = {
    message = "All Scalr resources and data sources tested without account_id attribute"
    resources_tested = [
      "scalr_access_policy",
      "scalr_agent_pool", 
      "scalr_agent_pool_token",
      "scalr_assume_service_account_policy",
      "scalr_environment",
      "scalr_environment_hook",
      "scalr_hook",
      "scalr_iam_team",
      "scalr_module",
      "scalr_module_namespace", 
      "scalr_policy_group",
      "scalr_policy_group_linkage",
      "scalr_provider_configuration",
      "scalr_provider_configuration_default",
      "scalr_role",
      "scalr_run_schedule_rule",
      "scalr_run_trigger",
      "scalr_service_account",
      "scalr_service_account_token",
      "scalr_ssh_key",
      "scalr_storage_profile",
      "scalr_tag",
      "scalr_variable",
      "scalr_vcs_provider",
      "scalr_webhook",
      "scalr_workload_identity_provider",
      "scalr_workspace",
      "scalr_workspace_run_schedule",
      "scalr_endpoint"
    ]
    data_sources_tested = [
      "scalr_access_policy",
      "scalr_agent_pool",
      "scalr_assume_service_account_policy",
      "scalr_current_account",
      "scalr_current_run",
      "scalr_endpoint",
      "scalr_environment",
      "scalr_environments",
      "scalr_hook",
      "scalr_iam_team",
      "scalr_iam_user",
      "scalr_module_version",
      "scalr_module_versions",
      "scalr_policy_group",
      "scalr_provider_configuration",
      "scalr_provider_configurations",
      "scalr_role",
      "scalr_service_account",
      "scalr_ssh_key",
      "scalr_storage_profile",
      "scalr_tag",
      "scalr_variable",
      "scalr_variables",
      "scalr_vcs_provider",
      "scalr_webhook",
      "scalr_workload_identity_provider",
      "scalr_workspace",
      "scalr_workspace_ids",
      "scalr_workspaces"
    ]
  }
}
