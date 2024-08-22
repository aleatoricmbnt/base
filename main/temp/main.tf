module "modules_terraform-null-module" {
	source  = "aleatoric.main.scalr.dev/acc-ttf6li416m4sbi0/modules/test//modules/terraform-null-module"
	version = "0.0.8"

	# Set 1 required variable below.

	# Number of resources to be created
 	quantity = 1
}
 

 resource "terraform_data" "this" {
   input = "my input"
   triggers_replace = var.trigger
 }

 variable "trigger" {
   
 }

 data "http" "example" {
  url = "https://www.random.org/integers/?num=1&min=0&max=9&base=10&col=1&format=plain"
}

output "data_out" {
  value = data.http.example.response_body
}

resource "time_static" "example" {}

output "current_time" {
  value = time_static.example.rfc3339
}

resource "local_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/foo.bar"
}

resource "tls_private_key" "ecdsa-p384-example" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}