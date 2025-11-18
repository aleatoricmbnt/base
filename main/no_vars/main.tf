resource "null_resource" "no_vars" {
  triggers = {
    "timestamp_2" = timestamp()
  }
}

resource "terraform_data" "oom_test" {
  depends_on = [null_resource.no_vars]
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

resource "random_string" "memory_eater" {
  count   = 10
  length  = 2 
  special = false
}


