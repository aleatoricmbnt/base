variable "environment" {
  type = string
}

locals {
  json_data = jsondecode(file("${path.module}/data/config.json"))
  csv_data  = file("${path.module}/data/users.csv")
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "terraform_data" "data_processor" {
  input = {
    environment = var.environment
    json_config = local.json_data
    random_id   = random_string.suffix.result
  }
}

output "random_value" {
  value = random_string.suffix.result
}
