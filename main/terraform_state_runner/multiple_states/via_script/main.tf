resource "null_resource" "multiple-states-via-script" {
  triggers = {
    time = timestamp()
  }
}

