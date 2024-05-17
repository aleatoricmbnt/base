variable "nullable" {
  type     = bool
}

resource "random_password" "name" {
  length = 16
  special = var.nullable
}

output "nullable_output" {
  value = var.nullable
}