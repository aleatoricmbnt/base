variable "nullable" {
  type     = string
  default = null
}

resource "null_resource" "name" {
}

output "nullable_output" {
  value = null
}