output "string_id" {
  value = module.hashicorp_registry_label.id
}

output "string_tags" {
  value = module.hashicorp_registry_label.tags
}

output "mod_random_result" {
  value = module.mod_random.result
}

output "mod_null_id" {
  value = module.mod_null.id
}

output "mod_terraform_data_output" {
  value = module.mod_terraform_data.output
}

output "mod_time_id" {
  value = module.mod_time.rotation_id
}

output "mod_tls_algorithm" {
  value = module.mod_tls.algorithm
}
