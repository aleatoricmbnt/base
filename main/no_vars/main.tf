resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_trigger" = timestamp()
  }
}
