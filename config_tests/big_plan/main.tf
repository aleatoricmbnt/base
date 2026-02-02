terraform {
  required_providers {
    # Cloud providers (large binaries)
    aws        = { source = "hashicorp/aws", version = "~> 5.0" }        # ~400MB
    google     = { source = "hashicorp/google", version = "~> 5.0" }     # ~200MB
    azurerm    = { source = "hashicorp/azurerm", version = "~> 3.0" }    # ~300MB
    
    # Kubernetes ecosystem (large)
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.0" }  # ~100MB
    helm       = { source = "hashicorp/helm", version = "~> 2.0" }        # ~80MB
    
    # Other HashiCorp products
    vault      = { source = "hashicorp/vault", version = "~> 3.0" }       # ~50MB
    consul     = { source = "hashicorp/consul", version = "~> 2.0" }      # ~50MB
    nomad      = { source = "hashicorp/nomad", version = "~> 2.0" }       # ~50MB
    
    # Popular third-party providers
    datadog    = { source = "datadog/datadog", version = "~> 3.0" }       # ~100MB
    newrelic   = { source = "newrelic/newrelic", version = "~> 3.0" }     # ~50MB
    cloudflare = { source = "cloudflare/cloudflare", version = "~> 4.0" } # ~80MB
    github     = { source = "integrations/github", version = "~> 5.0" }   # ~50MB
    gitlab     = { source = "gitlabhq/gitlab", version = "~> 16.0" }      # ~60MB
    
    # Database providers
    postgresql = { source = "cyrilgdn/postgresql", version = "~> 1.0" }   # ~30MB
    mysql      = { source = "petoju/mysql", version = "~> 3.0" }          # ~20MB
    
    # Other cloud providers
    oci        = { source = "oracle/oci", version = "~> 5.0" }            # ~200MB
    alicloud   = { source = "aliyun/alicloud", version = "~> 1.0" }       # ~100MB
    
    # Utility providers (smaller but still add up)
    random     = { source = "hashicorp/random", version = "~> 3.0" }
    null       = { source = "hashicorp/null", version = "~> 3.0" }
    local      = { source = "hashicorp/local", version = "~> 2.0" }
    tls        = { source = "hashicorp/tls", version = "~> 4.0" }
    http       = { source = "hashicorp/http", version = "~> 3.0" }
  }
}

locals {
  large_data = templatefile("${path.module}/large_template.tpl", {})
}

resource "terraform_data" "test" {
  input = local.large_data
}
