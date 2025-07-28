terraform {
  backend "gcs" {
    bucket  = "blob-tests"
    prefix  = "github/no_vars"
  }
}