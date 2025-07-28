terraform {
  backend "gcs" {
    bucket  = "blob_tests"
    prefix  = "github/no_vars"
  }
}