provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "kek"
  region = "us-east-1"
}

resource "random_pet" "bucket_name" {
  
}

resource "random_pet" "optional_bucket_name" {
  
}

resource "aws_s3_bucket" "default" {
  bucket = "aleatoric-bucket-${random_pet.bucket_name.id}"
}

variable "number_of_aliased_buckets" {
  default = 0
}

resource "aws_s3_bucket" "aliased" {
  provider = aws.kek
  count  = var.number_of_aliased_buckets
  bucket = "aleatoric-bucket-${random_pet.optional_bucket_name.id}"
}

terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
    }
  }
}


provider "scalr" {}

resource "scalr_workspace" "cli-driven" {
  name           = "automatically_created_${random_pet.bucket_name.id}"
  environment_id = data.scalr_current_run.this.environment_id
}

data "scalr_current_run" "this" {
  
}
