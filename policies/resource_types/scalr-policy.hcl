version = "v1"

policy "resource_types" {
  enabled           = true
  enforcement_level = "soft-mandatory"
}

policy "resource_types_copy" {
  enabled           = true
  enforcement_level = "hard-mandatory"
}