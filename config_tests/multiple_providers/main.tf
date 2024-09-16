resource "terraform_data" "this" {
   input = "my input"
   triggers_replace = var.trigger
 }

 variable "trigger" {
   default = "some_value"
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

resource "template_dir" "config" {
  source_dir      = "${path.cwd}/instance_config_templates"
  destination_dir = "${path.cwd}/instance_config"

  vars = {
    i_say = "${var.template_var}"
  }
}

variable "template_var" {
  default = "beep"
}