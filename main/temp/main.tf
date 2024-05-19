variable "nullable" {
  type     = string
  default = null
}

resource "null_resource" "name" {
  triggers = {
    trigger = var.nullable
  }
}

# output "nullable_output" {
#   value = var.nullable
# }