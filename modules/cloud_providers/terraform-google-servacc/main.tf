provider "google" {
  project = "personal-playground-437910"
}

resource "google_service_account" "service_acc" {
  account_id   = random_pet.service_acc_name.id
  display_name = random_pet.service_acc_name.id
}

resource "random_pet" "service_acc_name" {
  length = 3
}

# variable "google_project_id" {
#   default = null
# }

# output "service_account_name" {
#   value = provider::google::name_from_id(google_service_account.service_acc.id)
# }