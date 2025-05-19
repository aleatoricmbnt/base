resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_1" = timestamp()
  }
}

#comment
