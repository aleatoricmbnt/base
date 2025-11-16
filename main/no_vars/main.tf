resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "terraform_data" "oom_test" {
  depends_on = [null_resource.no_vars]
  provisioner "local-exec" {
    command = "sleep 3"
  }
}

resource "random_string" "memory_eater" {
  count   = 1000
  length  = 100
  special = false
}

