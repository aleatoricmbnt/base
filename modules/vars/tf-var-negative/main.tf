resource "null_resource" "name" {
  triggers = {
    time = timestamp()
  }
}


variable "untyped_A10" {
  default = 10
}

variable "untyped_A-10" {
  default = -10
}

variable "typed_B5" {
  default = 5
  type = number
}

variable "typed_B-5" {
  default = -5
  type = number
}

variable "string_C3" {
  default = "3"
  type = string
}

variable "string_C-3" {
  default = "-3"
  type = string
}

output "addition_A10_A-10" {
  value = var.untyped_A10 + var.untyped_A-10
}

output "substraction_A10_A-10" {
  value = var.untyped_A10 - var.untyped_A-10
}

output "addition_B5_B-5" {
  value = var.typed_B5 + var.typed_B-5
}

output "substraction_B5_B-5" {
  value = var.typed_B5 - var.typed_B-5
}

output "addition_C3_C-3" {
  value = var.string_C3 + var.string_C-3
}

output "substraction_C3_C-3" {
  value = var.string_C3 - var.string_C-3
}

output "hardcoded_negative_float" {
  value = -0.192
}
