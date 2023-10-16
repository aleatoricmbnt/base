terraform {
  required_version = "> 1.7.0"
}

resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
  }
}
