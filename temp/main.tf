resource "null_resouce" "name" {
  triggers = {
    time = timestamp()
  }
}