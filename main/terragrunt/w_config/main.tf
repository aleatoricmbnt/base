resource "terraform_data" "this" {
  input = var.input
  triggers_replace = var.triggers_replace
}

variable "input" {
  
}

variable "triggers_replace" {
  
}