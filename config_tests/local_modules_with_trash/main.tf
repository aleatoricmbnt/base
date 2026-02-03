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

# Validate all non-Terraform files exist during apply
resource "null_resource" "validate_all_files_on_apply" {
  triggers = {
    always_check = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOF
      echo "=== Verifying files exist during apply ==="
      
      files=(
        "modules/module_with_scripts/scripts/setup.sh"
        "modules/module_with_scripts/scripts/cleanup.py"
        "modules/module_with_scripts/data/config.txt"
        "modules/module_with_data/data/config.json"
        "modules/module_with_data/data/users.csv"
        "modules/module_with_data/data/metadata.yaml"
        "modules/module_with_data/README.md"
        "modules/module_mixed_files/config.hcl"
        "modules/module_mixed_files/template.tpl"
        "modules/module_mixed_files/init.sh"
        "modules/module_mixed_files/notes.txt"
      )
      
      missing_count=0
      for file in "$${files[@]}"; do
        if [ -f "$file" ]; then
          echo "✓ $file exists"
        else
          echo "✗ $file MISSING"
          missing_count=$((missing_count + 1))
        fi
      done
      
      if [ $missing_count -gt 0 ]; then
        echo "=== FAILED: $missing_count file(s) missing during apply ==="
        exit 1
      fi
      
      echo "=== SUCCESS: All $${#files[@]} files verified during apply ==="
    EOF
    
    interpreter = ["bash", "-c"]
  }

  depends_on = [
    module.module_with_scripts,
    module.module_with_data,
    module.module_mixed_files
  ]
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

locals {
  files_to_validate = {
    "setup.sh"       = fileexists("${path.module}/modules/module_with_scripts/scripts/setup.sh")
    "cleanup.py"     = fileexists("${path.module}/modules/module_with_scripts/scripts/cleanup.py")
    "config.txt"     = fileexists("${path.module}/modules/module_with_scripts/data/config.txt")
    "config.json"    = fileexists("${path.module}/modules/module_with_data/data/config.json")
    "users.csv"      = fileexists("${path.module}/modules/module_with_data/data/users.csv")
    "metadata.yaml"  = fileexists("${path.module}/modules/module_with_data/data/metadata.yaml")
    "README.md"      = fileexists("${path.module}/modules/module_with_data/README.md")
    "config.hcl"     = fileexists("${path.module}/modules/module_mixed_files/config.hcl")
    "template.tpl"   = fileexists("${path.module}/modules/module_mixed_files/template.tpl")
    "init.sh"        = fileexists("${path.module}/modules/module_mixed_files/init.sh")
    "notes.txt"      = fileexists("${path.module}/modules/module_mixed_files/notes.txt")
  }
  
  all_files_exist = alltrue(values(local.files_to_validate))
  missing_files = [for name, exists in local.files_to_validate : name if !exists]
}

output "plan_time_file_check" {
  value = {
    status              = local.all_files_exist ? "All files exist at plan time" : "Some files missing at plan time"
    files_checked       = local.files_to_validate
    missing_files       = local.missing_files
    total_files_checked = length(local.files_to_validate)
  }
  description = "File existence check at PLAN time (does not reflect apply-time status)"
}

output "apply_time_validation" {
  value = {
    status  = "File validation runs during apply via null_resource.validate_all_files_on_apply"
    message = "Check apply logs for actual file validation results during apply phase"
  }
  description = "Apply-time validation info - actual results appear in apply logs"
}
