terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "4.55"
        }
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "1.0.2"
        }
    }
}

provider "aws" {
  region = "us-east-1"
  access_key = "AKIAW3NB4JXWEDL3W4GH"
  secret_key = "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"
}



provider "scalr" {
  hostname = "mainiacp.provlock.testenv.scalr.dev"
  token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1c2VyIiwianRpIjoiYXQtdGsyNGhqY2U5cHRtN3VnIn0.U176hkJfV-Is4ZJNppwcObnemoogqxasu0RSMO4zj4o"
}

resource "scalr_tag" "example" {
  name       = "tag-name"
  account_id = "acc-svrcncgh453bi8g"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"
}

resource "null_resource" "name" {
  
}

resource "random_pet" "name" {
  
}