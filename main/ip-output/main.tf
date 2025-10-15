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

resource "terraform_data" "PR_check" {
  input = "PR_check"
  triggers_replace = timestamp()
}