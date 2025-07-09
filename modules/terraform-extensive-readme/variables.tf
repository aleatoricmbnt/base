variable "environment" {
  description = "Environment name for tagging and naming purposes"
  type        = string
  default     = "test"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]+$", var.environment))
    error_message = "Environment must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "string_length" {
  description = "Length of the random string to generate"
  type        = number
  default     = 16
  
  validation {
    condition     = var.string_length > 0 && var.string_length <= 100
    error_message = "String length must be between 1 and 100 characters."
  }
}

variable "include_special_chars" {
  description = "Whether to include special characters in the random string"
  type        = bool
  default     = true
}

variable "include_uppercase" {
  description = "Whether to include uppercase letters in the random string"
  type        = bool
  default     = true
}

variable "include_lowercase" {
  description = "Whether to include lowercase letters in the random string"
  type        = bool
  default     = true
}

variable "include_numbers" {
  description = "Whether to include numbers in the random string"
  type        = bool
  default     = true
}

variable "min_value" {
  description = "Minimum value for random integer generation"
  type        = number
  default     = 1
}

variable "max_value" {
  description = "Maximum value for random integer generation"
  type        = number
  default     = 100
  
  validation {
    condition     = var.max_value > var.min_value
    error_message = "Maximum value must be greater than minimum value."
  }
}

variable "uuid_count" {
  description = "Number of UUIDs to generate"
  type        = number
  default     = 3
  
  validation {
    condition     = var.uuid_count >= 0 && var.uuid_count <= 10
    error_message = "UUID count must be between 0 and 10."
  }
}

variable "create_files" {
  description = "Whether to create local files"
  type        = bool
  default     = true
}

variable "file_names" {
  description = "List of file names to create"
  type        = list(string)
  default     = ["test1.txt", "test2.txt", "config.json"]
  
  validation {
    condition     = length(var.file_names) > 0
    error_message = "At least one file name must be provided."
  }
}

variable "output_directory" {
  description = "Directory path where files will be created"
  type        = string
  default     = "/tmp/terraform-test"
}

variable "enable_provisioner" {
  description = "Whether to enable the null resource provisioner"
  type        = bool
  default     = false
}

variable "provisioner_command" {
  description = "Command to run in the provisioner"
  type        = string
  default     = "echo 'Running test provisioner'"
}

variable "read_existing_file" {
  description = "Whether to read an existing file"
  type        = bool
  default     = false
}

variable "existing_file_path" {
  description = "Path to an existing file to read"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "enable_debug" {
  description = "Enable debug mode for additional logging"
  type        = bool
  default     = false
}

variable "custom_config" {
  description = "Custom configuration object"
  type = object({
    name        = string
    enabled     = bool
    settings    = map(string)
    priorities  = list(number)
  })
  default = {
    name        = "default"
    enabled     = true
    settings    = {}
    priorities  = [1, 2, 3]
  }
} 