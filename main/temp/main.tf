resource "random_password" "password" {
  length           = 16
  special          = var.special_s
  lower = var.lower_s
}

variable "special_s" {
  type = bool
  default = false
}

variable "lower_s" {
  default = false
}