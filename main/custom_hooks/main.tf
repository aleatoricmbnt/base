resource "null_resource" "time" {
  triggers = {
    time = timestamp()
  }
}