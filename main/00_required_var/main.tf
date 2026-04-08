resource "terraform_data" "this" {
  input = [ var.input ]
  triggers_replace = timestamp()
}

variable "input" {
  type = string
}
