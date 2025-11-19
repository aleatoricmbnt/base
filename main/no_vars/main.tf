resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "random_string" "memory_eater" {
  count   = 10000
  length  = 100
  special = false
}

