variable "resource_count" {
  default = 1
}

variable "input" {
  default = "3"
}

resource "terraform_data" "test2" {
  input = var.input
  triggers_replace = timestamp()
}

output "test2" {
  value = terraform_data.test2.output
}
