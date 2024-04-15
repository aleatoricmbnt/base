resource "null_resource" "test" {
  triggers = {
    smth = var.some
  }
}

variable "some" {
  default = "account"
}