resource "null_resouce" "name" {
  triggers = {
    time = timestamp()
  }
}

output "nams" {
  value = null_resouce
}