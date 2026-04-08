terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-master"
      # version = "3.7.0"
    }
  }
}

# resource "terraform_data" "for_each_set" {
#   for_each = toset(["first.second.third"])
#   input = each.value
# }

resource "terraform_data" "for_each_map" {
  for_each = {
    "prod.env"    = "production.env"
    "dev.env"     = "development.env"
    "staging.env" = "staging.env"
  }
  input = each.value
}

resource "terraform_data" "for_each_set" {
  for_each = toset(["meep;meep;meep", "backslash\\backslash\\backslash", "one.two.three"])
  input = each.value
}

module "infrastructure" {
  source = "./modules/infra"
}

# Call test -> nested with count
module "test_module" {
  count  = 2
  source = "./modules/test"
}

# Call test -> nested with for_each_map
module "app_components" {
  for_each = {
    "frontend.web"    = "web-frontend"
  }
  source = "./modules/test"
}
