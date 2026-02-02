terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  template_1 = templatefile("${path.module}/template_1.tpl", {})
  template_2 = templatefile("${path.module}/template_2.tpl", {})
  template_3 = templatefile("${path.module}/template_3.tpl", {})
  template_4 = templatefile("${path.module}/template_4.tpl", {})
  template_5 = templatefile("${path.module}/template_5.tpl", {})
  
  large_string = "LARGE_DATA_STRING_PLACEHOLDER_THAT_WILL_BE_REPEATED_MANY_TIMES_TO_CREATE_A_BIG_PLAN_SIZE"
}

resource "terraform_data" "resource_001" {
  input = { id = "001", name = "resource_001", template = local.template_1, data = local.large_string, description = "Resource 1 with template data", tags = {environment = "test", index = "1"} }
}
resource "terraform_data" "resource_002" {
  input = { id = "002", name = "resource_002", template = local.template_2, data = local.large_string, description = "Resource 2 with template data", tags = {environment = "test", index = "2"} }
}
resource "terraform_data" "resource_003" {
  input = { id = "003", name = "resource_003", template = local.template_3, data = local.large_string, description = "Resource 3 with template data", tags = {environment = "test", index = "3"} }
}
resource "terraform_data" "resource_004" {
  input = { id = "004", name = "resource_004", template = local.template_4, data = local.large_string, description = "Resource 4 with template data", tags = {environment = "test", index = "4"} }
}
resource "terraform_data" "resource_005" {
  input = { id = "005", name = "resource_005", template = local.template_5, data = local.large_string, description = "Resource 5 with template data", tags = {environment = "test", index = "5"} }
}
resource "terraform_data" "resource_006" {
  input = { id = "006", name = "resource_006", template = local.template_1, data = local.large_string, description = "Resource 6 with template data", tags = {environment = "test", index = "6"} }
}
resource "terraform_data" "resource_007" {
  input = { id = "007", name = "resource_007", template = local.template_2, data = local.large_string, description = "Resource 7 with template data", tags = {environment = "test", index = "7"} }
}
resource "terraform_data" "resource_008" {
  input = { id = "008", name = "resource_008", template = local.template_3, data = local.large_string, description = "Resource 8 with template data", tags = {environment = "test", index = "8"} }
}
resource "terraform_data" "resource_009" {
  input = { id = "009", name = "resource_009", template = local.template_4, data = local.large_string, description = "Resource 9 with template data", tags = {environment = "test", index = "9"} }
}
resource "terraform_data" "resource_010" {
  input = { id = "010", name = "resource_010", template = local.template_5, data = local.large_string, description = "Resource 10 with template data", tags = {environment = "test", index = "10"} }
}

output "total_resources" {
  value       = 10
  description = "Total number of terraform_data resources - expand to 500 by duplicating pattern"
}
