output "workspace_id" {
  description = "ID of the created test workspace"
  value       = scalr_workspace.var_precedence_test.id
}

output "workspace_name" {
  description = "Name of the created test workspace"
  value       = scalr_workspace.var_precedence_test.name
}

output "variables_created" {
  description = "Variables created for precedence testing"
  value = {
    account_shell       = var.create_account_shell_variable > 0 ? scalr_variable.account_shell[0].value : "not created"
    environment_shell   = var.create_environment_shell_variable > 0 ? scalr_variable.environment_shell[0].value : "not created"
    workspace_shell     = var.create_workspace_shell_variable > 0 ? scalr_variable.workspace_shell[0].value : "not created"
    workspace_terraform = var.create_workspace_terraform_variable > 0 ? scalr_variable.workspace_terraform[0].value : "not created"
  }
}
