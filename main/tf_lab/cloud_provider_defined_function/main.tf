terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

resource "google_service_account" "service_acc" {
  account_id   = random_pet.service_acc_name.id
  display_name = random_pet.service_acc_name.id
}

resource "random_pet" "service_acc_name" {
  length = 3
}

output "service_account_name" {
  value = provider::google::name_from_id(google_service_account.service_acc.id)
}