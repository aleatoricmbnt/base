# Define variables with diverse validation rules

variable "string_variable" {
  description = "A string that must match a specific pattern."
  type        = string
  validation {
    condition     = can(regex("^hello", var.string_variable))
    error_message = "The string_variable must start with the word 'hello'. Please provide a value like 'hello_world'."
  }
}

variable "number_variable" {
  description = "A number that must be within a specific range."
  type        = number
  validation {
    condition     = var.number_variable >= 10 && var.number_variable <= 100
    error_message = "The number_variable must be between 10 and 100, inclusive. Please provide a number in this range."
  }
}

variable "bool_variable" {
  description = "A boolean variable that must be set to true."
  type        = bool
  validation {
    condition     = var.bool_variable == true
    error_message = "The bool_variable must be set to true to proceed. Please set it to true."
  }
}

variable "list_of_strings" {
  description = "A list of strings, each of which must have a minimum length."
  type        = list(string)
  validation {
    condition     = alltrue([for s in var.list_of_strings : length(s) >= 3])
    error_message = "Each item in list_of_strings must have at least 3 characters. Ensure all strings meet this requirement."
  }
}

variable "map_variable" {
  description = "A map with specific required keys."
  type        = map(string)
  validation {
    condition     = contains(keys(var.map_variable), "required_key")
    error_message = "The map_variable must contain the key 'required_key'. Ensure that this key is present."
  }
}

# Use terraform_data resources with the validated variables as inputs

resource "terraform_data" "example_string" {
  input = var.string_variable
}

resource "terraform_data" "example_number" {
  input = var.number_variable
}

resource "terraform_data" "example_bool" {
  input = var.bool_variable
}

resource "terraform_data" "example_list" {
  input = var.list_of_strings
}