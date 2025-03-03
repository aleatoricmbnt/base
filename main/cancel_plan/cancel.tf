data "external" "example" {
  program = ["bash", "./script.sh"]
  count = 100
}

resource "terraform_data" "to_generate_diff" {}