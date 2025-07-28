resource "terraform_data" "this" {
  input = [ var.input, var.input2 ]
  triggers_replace = var.triggers_replace
}

variable "input" {
  type = string
}

variable "input2" {
  type = string
}

variable "triggers_replace" {
  type = string
}