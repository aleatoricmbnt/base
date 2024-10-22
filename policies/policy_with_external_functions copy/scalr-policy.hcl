version = "v1"

policy "check_simple_rules" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "check_no_inputs" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

