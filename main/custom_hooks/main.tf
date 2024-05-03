resource "null_resource" "time" {
  triggers = {
    time = timestamp()
    mutated = var.custom_string
  }
}

variable "custom_string" {
  default = "main.tf string"
}

