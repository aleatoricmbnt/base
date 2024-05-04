resource "null_resource" "multiple-states-via-hook" {
  triggers = {
    time = timestamp()
  }
}