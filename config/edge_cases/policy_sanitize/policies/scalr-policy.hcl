version = "v1"

policy "deny_always_show_tfplan_variables" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "deny_always_show_terraform_data_input" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "deny_always_show_planned_outputs" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}
