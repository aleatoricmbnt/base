resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_1" = timestamp()
  }
}

resource "terraform_data" "this" {
  input = null_resource.no_vars.id
}

#comment
