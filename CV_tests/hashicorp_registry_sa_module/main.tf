# terraform {
#   backend "remote" {
#     hostname = "aleatoric.main.scalr.dev"
#     organization = "env-uae22veoi5c6d6o"
#     token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1c2VyIiwianRpIjoiYXQtdWQwbmQ1dmJvZDhldXYwIn0.WVMBh6Rdq_msih5gxyCaJiqzpVTIABJyO27RnHOLPK0"
#     # "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1c2VyIiwianRpIjoiYXQtdGsyNGhqY2U5cHRtN3VnIn0.U176hkJfV-Is4ZJNppwcObnemoogqxasu0RSMO4zj4o"

#     workspaces {
#       name = "CLI_module_report_test_2"
#     }
#   }
# }


module "service-accounts_example_single_service_account" {
  source     = "terraform-google-modules/service-accounts/google//examples/single_service_account"
  version    = "4.1.1"
  project_id = "fair-backbone-351510"
}
