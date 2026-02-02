terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Data source that creates a text file using external program
data "external" "create_source_file" {
  program = ["bash", "-c", <<-EOT
    echo 'Hello from Terraform! This file will be archived.' > source_file.txt
    echo '{"status":"created","filename":"source_file.txt"}'
  EOT
  ]
}

# Archive the created file
data "archive_file" "example_archive" {
  type        = "zip"
  output_path = "${path.module}/example_archive.zip"
  
  source {
    content  = "Hello from Terraform! This file will be archived."
    filename = "source_file.txt"
  }

  depends_on = [data.external.create_source_file]
}

# Another data source that creates a different file
data "external" "create_metadata_file" {
  program = ["bash", "-c", <<-EOT
    cat > metadata.txt << 'EOF'
Archive Metadata
Created: $(date '+%Y-%m-%d %H:%M:%S')
Archive Size: Pending
Status: Ready for extraction
EOF
    echo '{"status":"created","filename":"metadata.txt"}'
  EOT
  ]
}

# Extract the archive during Apply stage
resource "null_resource" "extract_archive" {
  triggers = {
    archive_hash = data.archive_file.example_archive.output_md5
  }

  provisioner "local-exec" {
    command = <<-EOT
      mkdir -p ./extracted
      unzip -o '${data.archive_file.example_archive.output_path}' -d ./extracted
      echo 'Archive extracted to ./extracted/'
    EOT
  }

  depends_on = [
    data.archive_file.example_archive,
    data.external.create_metadata_file
  ]
}

# Outputs for verification
output "archive_path" {
  value       = data.archive_file.example_archive.output_path
  description = "Path to the created archive"
}

output "archive_size" {
  value       = data.archive_file.example_archive.output_size
  description = "Size of the archive in bytes"
}

output "source_file_status" {
  value       = data.external.create_source_file.result.status
  description = "Status of source file creation"
}

output "metadata_file_status" {
  value       = data.external.create_metadata_file.result.status
  description = "Status of metadata file creation"
}
