resource "null_resource" "name" {
  triggers = {
    string = var.string_trigger
  }
}

variable "string_trigger" {
  default = "DEFAULT VALUE"
}