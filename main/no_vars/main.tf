resource "null_resource" "no_vars" {
count = 2
  triggers = {
    "timestamp" = timestamp()
  }
}
