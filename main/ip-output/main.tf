resource "terraform_data" "check_ip" {
  triggers_replace = timestamp()
  provisioner "local-exec" {
    command = "curl -s https://ifconfig.me/ip > ip.txt"
  }
}

data "local_file" "read_ip" {
  depends_on = [terraform_data.check_ip]
  filename   = "./ip.txt"
}

output "scalr_ip" {
  value = "Current instance IP is: ${data.local_file.read_ip.content}"
}

resource "terraform_data" "res1" {}

resource "terraform_data" "res2" {}
