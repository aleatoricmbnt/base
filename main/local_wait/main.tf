variable "sleep_time" {
  default = 1
}

resource "null_resource" "nr" {
  triggers = {
    trigger = timestamp()
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_time}"
  }
}
