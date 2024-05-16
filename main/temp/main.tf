terraform {
  required_providers {
    scalr = {
      source = "scalr/scalr"
    }
  }
}

resource "scalr_provider_configuration" "google" {
  name       = "google_main"
  account_id = var.acc_id
  google {
    credentials = var.g-creds
  }
}

variable "acc_id" {
  
}

variable "g-creds" {
  
}