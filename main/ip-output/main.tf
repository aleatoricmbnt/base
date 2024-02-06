resource "null_resource" "check_ip" {
  triggers = {
    current_time = timestamp()
  }
  provisioner "local-exec" {
    command = "curl -s https://ifconfig.me/ip > ip.txt"
  }
}

data "local_file" "read_ip" {
  depends_on = [null_resource.check_ip]
  filename   = "./ip.txt"
}

output "scalr_ip" {
  value = "Current instance IP is: ${data.local_file.read_ip.content}"
}

#some_comment + new resource

resource "null_resource" "check_ip" {
  triggers = {
    current_time = timestamp()
  }
}
