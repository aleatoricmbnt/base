resource "terraform_data" "this" {
  input = var.input
  triggers_replace = [ timestamp(), var.replace]
}

variable "input" {
  
}

variable "replace" {
  
}