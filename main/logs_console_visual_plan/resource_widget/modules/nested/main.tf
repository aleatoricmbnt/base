variable "parent_name" {
  description = "Name from parent module"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

# Deeply nested resources
resource "terraform_data" "nested_data" {
  for_each = {
    "service.auth"    = "auth-service"
    "service.storage" = "storage-service"
  }
  input = "${var.parent_name}-${each.value}-${var.env}"
}

resource "random_string" "nested_ids" {
  count   = 2
  length  = 6
  special = false
}
