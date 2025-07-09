output "random_string" {
  description = "Generated random string"
  value       = random_string.test_string.result
}

output "random_integer" {
  description = "Generated random integer"
  value       = random_integer.test_integer.result
}

output "random_uuids" {
  description = "Generated UUIDs"
  value       = random_uuid.test_uuid[*].result
}

output "created_files" {
  description = "Information about created files"
  value = var.create_files ? [
    for file in local_file.test_file : {
      filename = file.filename
      content_length = length(file.content)
      content_md5 = file.content_md5
    }
  ] : []
}

output "processed_data" {
  description = "Processed data from local values"
  value       = local.processed_data
}

output "summary_info" {
  description = "Summary information about the module execution"
  value       = local.summary_info
}

output "file_paths" {
  description = "Full paths of created files"
  value       = var.create_files ? [for file in local_file.test_file : file.filename] : []
}

output "existing_file_content" {
  description = "Content of existing file (if read)"
  value       = var.read_existing_file ? try(data.local_file.existing_file[0].content, null) : null
  sensitive   = true
}

output "module_metadata" {
  description = "Metadata about the module execution"
  value = {
    terraform_version = ">=1.0"
    module_path      = path.module
    execution_time   = timestamp()
    environment      = var.environment
    debug_enabled    = var.enable_debug
    custom_config    = var.custom_config
  }
}

output "resource_counts" {
  description = "Count of resources created by type"
  value = {
    random_strings   = 1
    random_integers  = 1
    random_uuids     = var.uuid_count
    local_files      = var.create_files ? length(var.file_names) : 0
    null_resources   = var.enable_provisioner ? 1 : 0
    data_sources     = var.read_existing_file ? 1 : 0
  }
}

output "configuration_summary" {
  description = "Summary of configuration options used"
  value = {
    string_config = {
      length          = var.string_length
      special_chars   = var.include_special_chars
      uppercase       = var.include_uppercase
      lowercase       = var.include_lowercase
      numbers         = var.include_numbers
    }
    integer_config = {
      min_value       = var.min_value
      max_value       = var.max_value
      range_size      = var.max_value - var.min_value
    }
    file_config = {
      create_files    = var.create_files
      file_count      = length(var.file_names)
      output_dir      = var.output_directory
    }
  }
} 