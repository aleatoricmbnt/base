version = "v1"

policy "enabled_passed" {
  enabled           = false
  enforcement_level = "advisory"
}

policy "enabled_failed" {
  enabled           = false
  enforcement_level = "soft-mandatory"
}

policy "disabled" {
  enabled           = false
  enforcement_level = "hard-mandatory"
}