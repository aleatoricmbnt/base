terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55"
    }
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "1.0.2"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "scalr_tag" "example" {
  name = "test-tag"
}

resource "aws_s3_bucket" "example" {
  bucket = "test-bucket"
}

resource "null_resource" "name" {

}

resource "random_pet" "name" {

}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "1.0.1"

  key_name        = "test-name"
  create_key_pair = false
  # ... omitted
}