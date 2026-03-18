terraform {
  required_version = ">= 1.5.0"

  required_providers {
    mything = {
      source  = "app.terraform.io/aleatoric/mything"
      version = "1.0.0"
    }
  }
}

provider "mything" {}

resource "terraform_data" "example" {
  input = {
    project_name = "example"
    environment  = "development"
    timestamp    = timestamp()
  }
}