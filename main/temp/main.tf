variable "nullable" {
  type     = string
  nullable = true
  default  = null
}

resource "null_resource" "nullable_trigger" {
  triggers = {
    example_variable = var.nullable != null ? var.nullable : "default_value"
  }
}

output "nullable_output" {
  value = var.nullable
}