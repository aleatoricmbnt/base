resource "terraform_data" "this" {
  input = var.check
  triggers_replace = var.replace
}

variable "check" {
  description = "Variable used to determine if policy check will fail"
  type = number
  default = 0
}

variable "replace" {
  description = "Change me if you want to recreate the resource"
  default = "kek"
}