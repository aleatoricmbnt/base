resource "null_resource" "no_vars" {
  triggers = {
    "timestamp" = timestamp()
  }
}


resource "null_resource" "no_vars2" {
  triggers = {
    "timestamp" = timestamp()
  }
}
