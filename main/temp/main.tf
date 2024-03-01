resource "null_resource" "always_replaced" {
  triggers = {
    current_time = timestamp()
  }
}