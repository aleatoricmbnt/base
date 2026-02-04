# Parse .terraform.lock.hcl and check .terraform folder sizes
data "external" "parse_lock_file" {
  program = ["bash", "-c", <<-EOF
    lockfile=".terraform.lock.hcl"
    
    if [ ! -f "$lockfile" ]; then
      echo '{"error":"lock_file_not_found","provider_count":"0","terraform_folder_size":"0","providers_folder_size":"0","modules_folder_size":"0","message":"Run terraform init first"}'
      exit 0
    fi
    
    # Count providers
    provider_count=$(grep -c "^provider " "$lockfile" || echo "0")
    
    # Extract provider names
    providers=$(grep "^provider " "$lockfile" | sed 's/provider "registry.terraform.io\///' | sed 's/"//' | sed 's/" {//' | tr '\n' ',' | sed 's/,$//')
    
    # Get lock file size
    file_size=$(stat -c %s "$lockfile" 2>/dev/null || stat -f %z "$lockfile" 2>/dev/null || echo "0")
    
    # Count total hashes
    hash_count=$(grep -c "^    \"h1:" "$lockfile" || echo "0")
    
    # Calculate .terraform folder size (total)
    if [ -d ".terraform" ]; then
      terraform_total=$(du -sb .terraform 2>/dev/null | cut -f1 || echo "0")
    else
      terraform_total="0"
    fi
    
    # Calculate .terraform/providers folder size
    if [ -d ".terraform/providers" ]; then
      providers_size=$(du -sb .terraform/providers 2>/dev/null | cut -f1 || echo "0")
    else
      providers_size="0"
    fi
    
    # Calculate .terraform/modules folder size
    if [ -d ".terraform/modules" ]; then
      modules_size=$(du -sb .terraform/modules 2>/dev/null | cut -f1 || echo "0")
    else
      modules_size="0"
    fi
    
    echo "{\"provider_count\":\"$provider_count\",\"lock_file_size_bytes\":\"$file_size\",\"total_hashes\":\"$hash_count\",\"providers\":\"$providers\",\"terraform_folder_size\":\"$terraform_total\",\"providers_folder_size\":\"$providers_size\",\"modules_folder_size\":\"$modules_size\"}"
  EOF
  ]
}

# Simple resource to test provider loading
resource "terraform_data" "provider_test" {
  input = {
    lock_file_data = data.external.parse_lock_file.result
    timestamp      = timestamp()
  }
}

output "providers_from_lock_file" {
  value = {
    provider_count    = data.external.parse_lock_file.result.provider_count
    lock_file_size_kb = tonumber(data.external.parse_lock_file.result.lock_file_size_bytes) / 1024
    total_hashes      = data.external.parse_lock_file.result.total_hashes
    provider_list     = split(",", data.external.parse_lock_file.result.providers)
  }
  description = "Actual provider information extracted from .terraform.lock.hcl"
}

output "terraform_folder_sizes" {
  value = {
    terraform_total_mb = tonumber(data.external.parse_lock_file.result.terraform_folder_size) / 1024 / 1024
    providers_mb       = tonumber(data.external.parse_lock_file.result.providers_folder_size) / 1024 / 1024
    modules_mb         = tonumber(data.external.parse_lock_file.result.modules_folder_size) / 1024 / 1024
    
    terraform_total_bytes = data.external.parse_lock_file.result.terraform_folder_size
    providers_bytes       = data.external.parse_lock_file.result.providers_folder_size
    modules_bytes         = data.external.parse_lock_file.result.modules_folder_size
  }
  description = "Size of .terraform folder and its subdirectories"
}

module "no_vars" {
  source = "git::https://github.com/aleatoricmbnt/flat.git?ref=symlink-main-tf"
}

# module "symlink_test" {
#   source = "git::https://github.com/aleatoricmbnt/base.git//config_tests/symlink_tfvars?ref=symlink"
# }

# module "readme_links" {
#   source = "git::https://github.com/aleatoricmbnt/base.git//main/readme_links?ref=master"
# }