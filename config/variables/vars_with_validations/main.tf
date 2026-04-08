# Define variables with diverse validation rules, using only supported functions

variable "string_variable" {
  description = "A string that must start with the word 'hello'."
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

variable "list_of_strings" {
  description = "A list of strings, each of which must have a minimum length of 3 characters."
  type        = list(string)
  validation {
    condition     = alltrue([for s in var.list_of_strings : length(trimspace(s)) >= 3])
    error_message = "Each item in list_of_strings must have at least 3 characters. Ensure all strings meet this requirement."
  }
}

variable "list_with_unique_elements" {
  description = "A list of strings where all elements must be unique."
  type        = list(string)
  validation {
    condition     = length(distinct(var.list_with_unique_elements)) == length(var.list_with_unique_elements)
    error_message = "All elements in list_with_unique_elements must be unique. Ensure no duplicates are present."
  }
}

variable "map_variable" {
  description = "A map that must contain the required key 'required_key'."
  type        = map(string)
  validation {
    condition     = contains(keys(var.map_variable), "required_key")
    error_message = "The map_variable must contain the key 'required_key'. Ensure that this key is present in the map."
  }
}

# Use terraform_data resources with the validated variables as inputs


resource "terraform_data" "example_string" {
  input = var.string_variable
}

resource "terraform_data" "example_number" {
  input = var.number_variable
}

resource "terraform_data" "example_list" {
  input = var.list_of_strings
}

resource "terraform_data" "example_unique_list" {
  input = var.list_with_unique_elements
}

resource "terraform_data" "example_map" {
  input = var.map_variable
}