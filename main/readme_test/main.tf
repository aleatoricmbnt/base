resource "terraform_data" "this" {
  input = var.input
  triggers_replace = [ timestamp(), var.replace]
}

variable "input" {
  default = "123"
}

variable "replace" {
  default = "123"
}
