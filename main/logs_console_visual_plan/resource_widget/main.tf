terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-master"
      # version = "3.7.0"
    }
  }
}

data "scalr_current_run" "this" {}

resource "scalr_workspace" "system_workspace_env" {
  # for_each = {
  #   "SnowflakeIAM.dev" = {
  #     name           = "snowflake-iam-dev"
  #     environment_id = data.scalr_current_run.this.environment_id
  #   }
  #   "Dataprodukter.prod" = {
  #     name           = "snowflake-iam-prod" 
  #     environment_id = data.scalr_current_run.this.environment_id
  #   }
  # }
  
  # name           = each.value.name
  # environment_id = each.value.environment_id
  for_each = toset(["first.second.third", "one.two.three"])
  
  name           = each.value
  environment_id = data.scalr_current_run.this.environment_id
}

# # Indexed terraform_data resources
# resource "terraform_data" "example" {
#   count = 3
#   input = "data-${count.index}"
# }

# resource "terraform_data" "keyed" {
#   for_each = {
#     "prod"    = "production"
#     "dev"     = "development"
#     "staging" = "staging"
#   }
#   input = each.value
# }

# # Indexed null resources
# resource "null_resource" "simple" {
#   count = 2
  
#   provisioner "local-exec" {
#     command = "echo 'Resource ${count.index}'"
#   }
# }

# resource "null_resource" "complex" {
#   for_each = {
#     "app.frontend" = "frontend-config"
#     "app.backend"  = "backend-config"
#     "db.primary"   = "primary-db"
#   }
  
#   provisioner "local-exec" {
#     command = "echo '${each.key}: ${each.value}'"
#   }
# }

# # Indexed random resources
# resource "random_string" "ids" {
#   count   = 4
#   length  = 8
#   special = false
# }

# resource "random_password" "secrets" {
#   for_each = {
#     "user.admin"     = 16
#     "service.api"    = 32
#     "db.connection"  = 24
#   }
#   length  = each.value
#   special = true
# }

# # Module calls with different names and indexes
# module "test_module" {
#   count  = 2
#   source = "./modules/test"
  
#   name_prefix = "test-${count.index}"
#   environment = count.index == 0 ? "prod" : "dev"
# }

# module "app_components" {
#   for_each = {
#     "frontend.web"    = "web-frontend"
#     "backend.api"     = "api-backend"
#     "worker.queue"    = "queue-worker"
#   }
#   source = "./modules/test"
  
#   name_prefix = each.value
#   environment = "production"
# }

# module "infrastructure" {
#   source = "./modules/infra"
  
#   project_name = "scalr-test"
# }

# module "indexed_infra" {
#   count  = 2
#   source = "./modules/infra"
  
#   project_name = "scalr-indexed-${count.index}"
# }
