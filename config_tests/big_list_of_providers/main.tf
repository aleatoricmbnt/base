terraform {
  required_providers {
    # Major Cloud Providers (Large binaries)
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    } # ~400MB

    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    } # ~200MB

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    } # ~300MB

    # Other Major Cloud Providers
    oci = {
      source  = "oracle/oci"
      version = "~> 5.0"
    } # ~200MB

    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.0"
    } # ~100MB

    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.0"
    } # ~150MB

    # Container & Kubernetes Ecosystem
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    } # ~100MB

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    } # ~80MB

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    } # ~50MB

    # HashiCorp Product Providers
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    } # ~50MB

    consul = {
      source  = "hashicorp/consul"
      version = "~> 2.0"
    } # ~50MB

    nomad = {
      source  = "hashicorp/nomad"
      version = "~> 2.0"
    } # ~50MB

    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.0"
    } # ~40MB

    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.0"
    } # ~30MB

    # Monitoring & Observability
    datadog = {
      source  = "datadog/datadog"
      version = "~> 3.0"
    } # ~100MB

    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 3.0"
    } # ~50MB

    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = "~> 3.0"
    } # ~40MB

    grafana = {
      source  = "grafana/grafana"
      version = "~> 2.0"
    } # ~50MB

    # DNS & CDN Providers
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    } # ~80MB

    akamai = {
      source  = "akamai/akamai"
      version = "~> 5.0"
    } # ~60MB

    ns1 = {
      source  = "ns1-terraform/ns1"
      version = "~> 2.0"
    } # ~30MB

    # VCS & CI/CD Platforms
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    } # ~50MB

    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.0"
    } # ~60MB

    bitbucket = {
      source  = "DrFaust92/bitbucket"
      version = "~> 2.0"
    } # ~30MB

    # Database Providers
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.0"
    } # ~30MB

    mysql = {
      source  = "petoju/mysql"
      version = "~> 3.0"
    } # ~20MB

    mongodb = {
      source  = "mongodb/mongodbatlas"
      version = "~> 1.0"
    } # ~40MB

    # Communication & Collaboration
    slack = {
      source  = "pablovarela/slack"
      version = "~> 1.0"
    } # ~20MB

    opsgenie = {
      source  = "opsgenie/opsgenie"
      version = "~> 0.6"
    } # ~30MB

    jenkins = {
      source  = "taiidani/jenkins"
      version = "~> 0.0"
    } # ~20MB

    # Security & Identity
    okta = {
      source  = "okta/okta"
      version = "~> 4.0"
    } # ~50MB

    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.0"
    } # ~30MB

    # Utility Providers (Small but essential)
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }

    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

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
