provider "google" {
  project = var.project_id
}

resource "random_pet" "bucket_name" {
  length = 3
}

resource "google_storage_bucket" "example_bucket" {
  name          = "mshytse-${random_pet.bucket_name.id}"
  location      = var.location
  storage_class = "STANDARD"

  versioning {
    enabled = false
  }
}

variable "location" {
  type = string
  default = "europe-west1"
}

variable "project_id" {
  type = string
  default = "scalr-dev"
}