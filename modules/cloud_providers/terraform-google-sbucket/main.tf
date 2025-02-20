provider "google" {
  project = "scalr-dev"
}

resource "random_pet" "bucket_name" {
  length = 3
}

resource "google_storage_bucket" "example_bucket" {
  name          = random_pet.bucket_name.id
  location      = "europe-west1"
  storage_class = "STANDARD"

  versioning {
    enabled = false
  }
}