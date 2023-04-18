resource "null_resource" "test" {
  triggers = {
    trigger = var.string
  }
}

variable "string" {
  type = string
}