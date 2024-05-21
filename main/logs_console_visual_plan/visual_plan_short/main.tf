# ----------------------------------------------------------------------------------------- #

resource "terraform_data" "list_untyped_nested_object" {
  input = var.list_untyped
  triggers_replace  = var.type_any
}

variable "list_untyped" {}

variable "type_any" {
  type = any
}

# ----------------------------------------------------------------------------------------- #

data "local_file" "json" {
  filename = "./sample.json"
}

resource "terraform_data" "local_json" {
  input = data.local_file.json.content
}

# ----------------------------------------------------------------------------------------- #