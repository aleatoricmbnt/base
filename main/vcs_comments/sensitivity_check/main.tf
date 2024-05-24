terraform {
  required_providers {
    scalr = {
        source = "scalr/scalr"
    }
  }
}

resource "terraform_data" "remington_700" {
  triggers_replace = timestamp()
}

variable "sensitive_resource_name" {
  default = "remington_700"
  sensitive = true
}

output "remington_700_out" {
  value = var.sensitive_resource_name
  sensitive = true
}

# ----------------------------------------- #

resource "null_resource" "glock17" {
  triggers = {
    time = timestamp()
  }
}

variable "sensitive_resource_type" {
  default = "null_resource"
  sensitive = true
}

output "glock17_out" {
  value = var.sensitive_resource_type
  sensitive = true
}

# ----------------------------------------- #

resource "random_pet" "sensitive_shell_variable" { # create 2 sensitive shell variables with resource type and resource name values
  keepers = {
    time = timestamp()
  }
}

# ----------------------------------------- #

output "single_line" { # create sensitive shell variable with the same value as output
  value = "Single line output"
}

output "multi_line" { # create sensitive shell variable with the same value as output
  value = {
    "product": {
        "id": "12345",
        "name": "Wireless Mouse",
        "price": 25.99,
        "in_stock": true,
        "specifications": {
        "color": "black",
        "connectivity": "wireless",
        "battery_life": "12 months"
        }
    }
  }
}

output "single_line_sensitive" {
  value = "Single line sensitive output"
  sensitive = true
}

output "multi_line_sensitive" {
  value = <<-EOT
{
  "user": {
    "id": "67890",
    "username": "johndoe",
    "email": "johndoe@example.com",
    "profile": {
      "first_name": "John",
      "last_name": "Doe",
      "age": 30,
      "address": {
        "street": "123 Main St",
        "city": "Anytown",
        "state": "CA",
        "zip_code": "12345"
      }
    }
  }
}
  EOT
  sensitive = true
}

# ----------------------------------------- #

variable "created_workspace_id" { # set the created workspace id once applied
  sensitive = true
  default = "ws-xxxx"
}

data "scalr_current_run" "this" {
  
}

resource "scalr_workspace" "sensitive_id" {
  name = "workspace4"
  environment_id = data.scalr_current_run.this.environment_id
}
