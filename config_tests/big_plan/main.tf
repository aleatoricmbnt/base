terraform {
  required_providers {
    # Multiple providers = larger .terraform directory
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
    google = { source = "hashicorp/google", version = "~> 5.0" }
    azurerm = { source = "hashicorp/azurerm", version = "~> 3.0" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.0" }
  }
}

resource "null_resource" "create_large_files" {
  provisioner "local-exec" {
    command = <<-EOT
      # Create 100MB of random files in subdirectories
      for i in {1..100}; do
        mkdir -p large_data_$i
        dd if=/dev/urandom of=large_data_$i/file_$i.bin bs=1M count=1
      done
    EOT
  }
}

resource "random_id" "test" {
  byte_length = 4
  depends_on = [null_resource.create_large_files]
}

