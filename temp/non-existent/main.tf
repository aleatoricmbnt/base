resource "null_resource" "name" {
  triggers = {
    time = timestamp()
  }
}