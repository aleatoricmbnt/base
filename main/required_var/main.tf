resource "terraform_data" "this" {
  input = var.input
  triggers_replace = var.triggers_replace
}

variable "input" {
  type = string
}

variable "triggers_replace" {
  type = string
}