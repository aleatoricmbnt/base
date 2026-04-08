resource "null_resource" "nested" {
  triggers = {
    time = timestamp()
  }
}