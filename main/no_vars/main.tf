resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
  }
}