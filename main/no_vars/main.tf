resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "random_string" "memory_eater" {
  count   = 100000
  length  = 10000  
  special = false
}
