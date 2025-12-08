terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.59.0"
    }
    google = {
      source = "hashicorp/google"
      version = "7.12.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "kek"
  region = "us-east-1"
}

provider "google" {
  project = "password-project-375916"
}


provider "google" {
  alias  = "lol"
  project = "personal-playground-437910"
}

resource "random_pet" "bucket_name" {}

resource "random_pet" "optional_bucket_name" {}

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

resource "google_service_account" "default" {
  account_id   = random_pet.service_acc_name.id
  display_name = random_pet.service_acc_name.id
}

resource "random_pet" "service_acc_name" {}

variable "number_of_aliased_servaccs" {}

resource "random_pet" "optional_service_acc_name" {}

resource "google_service_account" "optional" {
  provider = google.lol
  count = var.number_of_aliased_servaccs
  account_id   = "aleatoric-${random_pet.optional_service_acc_name.id}"
  display_name = "aleatoric-${random_pet.optional_service_acc_name.id}"
}