resource "null_resource" "name" {
  triggers = {
    string = var.string-trigger
  }
}

variable "string-trigger" {
  default = "DEFAULT VALUE"
}