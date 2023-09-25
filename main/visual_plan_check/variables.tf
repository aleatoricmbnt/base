variable "triggers_to_be_joined" {
  type = map(string)
  default = {
    name           = "John Doe"
    age            = "30"
    city           = "New York"
    country        = "United States"
    favorite_color = "Blue"
    occupation     = "Software Engineer"
    education      = "Bachelor's Degree"
    hobby          = "Photography"
    team           = "Terraform Enthusiasts"
    project        = "Infrastructure Automation"
    company        = "TechCorp Inc."
    status         = "Active"
    email          = "john.doe@example.com"
    phone          = "+1 (555) 123-4567"
    website        = "https://www.example.com"
    timezone       = "UTC-5"
    start_date     = "2022-01-15"
    end_date       = "2022-12-31"
    salary         = "80000"
  }
}

variable "basic" {
  default = "ABC123"
}

variable "layered" {
  type = object({
    layer1 = object({
      layer2 = object({
        layer3 = object({
          value1 = string
          value2 = string
          value3 = string
        })
      })
    })
  })
  default = {
    layer1 = {
      layer2 = {
        layer3 = {
          value1 = "Value for Layer 1"
          value2 = "Value for Layer 2"
          value3 = "Value for Layer 3"
        }
      }
    }
  }
}

variable "env-id" {
  description = "ID of the environment to create workspace in"
}

variable "secrets" {
  type = object({
    username = string
    password = string
  })
  sensitive = true
  default = {
    username = "admin"
    password = "c!Sx&n8MfZ#jK$4E"
  }
}

variable "marked_as_sensitive_on_UI" {
  description = "Set any value here, but mark as sensitive via Scalr UI"
}


variable "change_me_upper" {
  type        = bool
  description = "CHANGE ME TO 'false'"
  default     = true
}

variable "change_me_min_lower" {
  type        = number
  description = "CHANGE ME TO '10'"
  default     = 2
}


variable "pg-reference-name" {
  description = "Name of the exisiting policy group for the data_source. Exisiting policy group will be used as a reference and the duplicate will be created."
}