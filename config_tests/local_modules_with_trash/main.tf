terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Reference to local module with scripts and data files
module "module_with_scripts" {
  source = "./modules/module_with_scripts"
  
  prefix = "test"
}

# Reference to local module with JSON and CSV data
module "module_with_data" {
  source = "./modules/module_with_data"
  
  environment = "dev"
}

# Reference to local module with mixed terraform and non-terraform files
module "module_mixed_files" {
  source = "./modules/module_mixed_files"
  
  instance_count = 3
}

# Output to verify modules are loaded
output "modules_loaded" {
  value = {
    scripts_module = module.module_with_scripts.resource_id
    data_module    = module.module_with_data.random_value
    mixed_module   = module.module_mixed_files.data_id
  }
  description = "Outputs from local modules with various files"
}
