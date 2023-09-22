terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.27"
    }
  }
}

# -------------------------------------------------------------------------------------------
# ----------------------------------- CONFIGURE PROVIDERS -----------------------------------
# -------------------------------------------------------------------------------------------

provider "google" {
  project = var.google_project_id
}

# -------------------------------------------------------------------------------------------
# ------------------------------------------ GOOGLE -----------------------------------------
# -------------------------------------------------------------------------------------------

resource "google_service_account" "gcp_service-acc" {
  account_id   = var.service-account_id
  display_name = var.service-account_name
}

variable "service-account_id" {
  type    = string
  default = "pcfg-mmoh-test"
}

variable "service-account_name" {
  type    = string
  default = "PCFG Service Account"
}

variable "google_project_id" {
  default = null
}