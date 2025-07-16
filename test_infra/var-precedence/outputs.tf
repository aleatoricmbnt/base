output "workspace_id" {
  description = "ID of the created test workspace"
  value       = scalr_workspace.var_precedence_test.id
}

output "workspace_name" {
  description = "Name of the created test workspace"
  value       = scalr_workspace.var_precedence_test.name
}
