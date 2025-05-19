resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_trgg" = timestamp()
  }
}

resource "terraform_data" "this" {}
