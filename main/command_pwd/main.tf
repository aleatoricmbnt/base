resource "null_resource" "provisioner" {
  triggers = {
    current_time = (formatdate("YYYY-MM-DD_hh:mm:ss",timestamp()))
  }
  provisioner "local-exec" {
    command = "./script.sh"
  }
}