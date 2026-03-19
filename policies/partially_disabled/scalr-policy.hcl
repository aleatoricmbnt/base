version = "v1"

policy "enabled_passed" {
  enabled           = true
  enforcement_level = "advisory"
}

policy "disabled" {
  enabled           = false
  enforcement_level = "hard-mandatory"
}