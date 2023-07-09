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

variable "untyped_list" {
  value = [-9, "untyped list index 0"]
}

variable "typed_object" {
  type = object({
    str_attr = string
    num_attr = number
    list_attr = list(any)
  })
  value = {
    str_attr = "Hello world!"
    num_attr = -7.32
    list_attr = ["list_attr value 0", -3.64, 0]
  }
}

output "list_addition" {
  value = var.untyped_list[0] + var.typed_object["num_attr"]
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
