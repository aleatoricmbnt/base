resource "null_resource" "name" {
  triggers = {
    long = var.long_var
  }
}

variable "long_var" {
  default = 2
}