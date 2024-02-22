resource "null_resource" "top" {
  triggers = {
    time = timestamp()
  }
}