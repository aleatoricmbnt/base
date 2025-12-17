variable "resource_count" {
  default = 1
}

variable "input" {
  default = "batch6"
}

resource "terraform_data" "test2" {
  input = var.input
  triggers_replace = timestamp()
}

output "test2" {
  value = terraform_data.test2.output
}
