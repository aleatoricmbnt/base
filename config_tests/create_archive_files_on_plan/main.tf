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
  program = ["bash", "-c", "echo 'Hello from Terraform! This file will be archived.' > ${path.module}/source_file.txt && echo '{\"status\":\"created\",\"filename\":\"source_file.txt\"}'"]
}

# Archive the created file
data "archive_file" "example_archive" {
  type        = "zip"
  output_path = "${path.module}/example_archive.zip"
  
  source_file = "${path.module}/source_file.txt"

  depends_on = [data.external.create_source_file]
}

# Another data source that creates a different file
data "external" "create_metadata_file" {
  program = ["bash", "-c", "printf 'Archive Metadata\\nCreated: %s\\nArchive Size: Pending\\nStatus: Ready for extraction\\n' \"$(date '+%Y-%m-%d %H:%M:%S')\" > ${path.module}/metadata.txt && echo '{\"status\":\"created\",\"filename\":\"metadata.txt\"}'"]
}

# Extract the archive during Apply stage
resource "null_resource" "extract_archive" {
  triggers = {
    archive_hash = data.archive_file.example_archive.output_md5
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "mkdir -p ./extracted && unzip -o '${data.archive_file.example_archive.output_path}' -d ./extracted && echo 'Archive extracted to ./extracted/'"
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
