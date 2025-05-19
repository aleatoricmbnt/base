resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}
