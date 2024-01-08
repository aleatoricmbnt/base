resource "null_resouce" "" {
  triggers = {
    time = timestamp()
  }
}