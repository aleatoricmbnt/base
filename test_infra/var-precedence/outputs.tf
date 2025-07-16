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
    account_shell     = scalr_variable.account_shell.value
    environment_shell = scalr_variable.environment_shell.value
    workspace_shell   = scalr_variable.workspace_shell.value
    workspace_terraform = scalr_variable.workspace_terraform.value
  }
} 