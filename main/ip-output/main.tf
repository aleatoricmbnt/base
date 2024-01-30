resource "null_resource" "check_ip" {
  triggers = {
    current_time = timestamp()
    variable_trigger = var.my-var
  }
  provisioner "local-exec" {
    command = "curl -s https://ifconfig.me/ip > ip.txt"
  }
}

variable "my-var" {

}

data "local_file" "read_ip" {
  depends_on = [null_resource.check_ip]
  filename   = "./ip.txt"
}

output "scalr_ip" {
  value = "Current instance IP is: ${data.local_file.read_ip.content}"
}
