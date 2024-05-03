terraform {
  required_providers {
    mycloud = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

resource "null_resource" "name" {
  triggers = {
    time = timestamp()
  }
}