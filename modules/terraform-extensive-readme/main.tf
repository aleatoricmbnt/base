# Terraform and provider requirements are defined in versions.tf

# Input validation for cross-variable constraints
locals {
  # Validate that max_value > min_value
  _validate_integer_range = var.max_value > var.min_value ? null : tobool("max_value (${var.max_value}) must be greater than min_value (${var.min_value})")
}

# Generate random values for testing
resource "random_string" "test_string" {
  length  = var.string_length
  special = var.include_special_chars
  upper   = var.include_uppercase
  lower   = var.include_lowercase
  numeric = var.include_numbers
}

resource "random_integer" "test_integer" {
  min = var.min_value
  max = var.max_value
}

resource "random_uuid" "test_uuid" {
  count = var.uuid_count
}

# Create local files for testing
resource "local_file" "test_file" {
  count = var.create_files ? length(var.file_names) : 0
  
  content = templatefile("${path.module}/templates/test_file.tpl", {
    file_name    = var.file_names[count.index]
    random_string = random_string.test_string.result
    random_integer = random_integer.test_integer.result
    timestamp    = timestamp()
    environment  = var.environment
  })
  
  filename = "${var.output_directory}/${var.file_names[count.index]}"
}

# Null resource for running provisioners
resource "null_resource" "test_provisioner" {
  count = var.enable_provisioner ? 1 : 0
  
  triggers = {
    string_value  = random_string.test_string.result
    integer_value = random_integer.test_integer.result
    timestamp     = timestamp()
  }
  
  provisioner "local-exec" {
    command = var.provisioner_command
    
    environment = {
      TEST_STRING  = random_string.test_string.result
      TEST_INTEGER = random_integer.test_integer.result
      TEST_ENV     = var.environment
    }
  }
}

# Data source for testing
data "local_file" "existing_file" {
  count    = var.read_existing_file ? 1 : 0
  filename = var.existing_file_path
}

# Local values for complex transformations
locals {
  processed_data = {
    for i, name in var.file_names : name => {
      index         = i
      uppercase     = upper(name)
      lowercase     = lower(name)
      random_suffix = substr(random_string.test_string.result, 0, 5)
      full_path     = "${var.output_directory}/${name}"
    }
  }
  
  summary_info = {
    total_files      = length(var.file_names)
    total_uuids      = var.uuid_count
    environment      = var.environment
    string_length    = var.string_length
    random_range     = "${var.min_value}-${var.max_value}"
    creation_time    = timestamp()
  }
} 