version = "v1"

policy "rego_type_error" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "undefined" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}