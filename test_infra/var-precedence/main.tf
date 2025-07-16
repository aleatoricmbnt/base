terraform {
  required_providers {
    scalr = {
      source  = "scalr/scalr"
      version = "~> 2.0"
    }
  }
}

# Get current environment
data "scalr_current_run" "this" {}

# Create test workspace
resource "scalr_workspace" "var_precedence_test" {
  name            = var.test_workspace_name
  environment_id  = data.scalr_current_run.this.environment_id
  vcs_provider_id = var.vcs_provider_id

  # Set custom var-file
  var_files = var.var_files

  working_directory = "test_source/var-precedence"

  vcs_repo {
    identifier       = "aleatoricmbnt/base"
    branch           = "master"
  }
}


# Create variables at different precedence levels
resource "scalr_variable" "account_shell" {
  count      = var.create_account_shell_variable
  key        = "TF_VAR_test_var"
  value      = "account-shell-value"
  category   = "shell"
}

resource "scalr_variable" "environment_shell" {
  count          = var.create_environment_shell_variable
  key            = "TF_VAR_test_var"
  value          = "environment-shell-value"
  category       = "shell"
  environment_id = data.scalr_current_run.this.environment_id
}

resource "scalr_variable" "workspace_shell" {
  count        = var.create_workspace_shell_variable
  key          = "TF_VAR_test_var"
  value        = "workspace-shell-value"
  category     = "shell"
  workspace_id = scalr_workspace.var_precedence_test.id
}

resource "scalr_variable" "workspace_terraform" {
  count        = var.create_workspace_terraform_variable
  key          = "test_var"
  value        = "workspace-terraform-value"
  category     = "terraform"
  workspace_id = scalr_workspace.var_precedence_test.id
} 