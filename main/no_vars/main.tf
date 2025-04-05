resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
    "my_string" = "custom_string_from_the_fork"
  }
}
