variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

# Resources within the test module
resource "terraform_data" "module_data" {
  input = "${var.name_prefix}-${var.environment}"
}

resource "null_resource" "module_null" {
  count = 2
  
  provisioner "local-exec" {
    command = "echo 'Module resource ${var.name_prefix}-${count.index}'"
  }
}

resource "random_string" "module_random" {
  for_each = {
    "config.primary"   = 8
    "config.secondary" = 12
  }
  length  = each.value
  special = false
}

# Nested module call
module "nested" {
  source = "../nested"
  
  parent_name = var.name_prefix
  env         = var.environment
}
