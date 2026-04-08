terraform {
  backend "gcs" {
    bucket  = "state_storage_mshytse"
    prefix  = "github"
  }
}
