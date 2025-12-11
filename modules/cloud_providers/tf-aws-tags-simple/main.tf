terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  a = "1"
}
locals {
  other_tags = {"b": "1"}
}


provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = local.other_tags
  }
}


resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "simple_bucket" {
  bucket = "scalr-simple-tags-${random_id.bucket_suffix.hex}"
}