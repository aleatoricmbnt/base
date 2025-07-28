# =============================================================================
# TERRAFORM CONFIGURATION WITH 20+ FREE RESOURCES, VARIABLES, AND OUTPUTS
# =============================================================================

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# =============================================================================
# VARIABLES (20+)
# =============================================================================

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "demo-project"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "team_name" {
  description = "Name of the team"
  type        = string
  default     = "platform-team"
}

variable "region" {
  description = "Target region"
  type        = string
  default     = "us-west-2"
}

variable "instance_count" {
  description = "Number of instances to simulate"
  type        = number
  default     = 3
}

variable "enable_monitoring" {
  description = "Enable monitoring features"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable logging features"
  type        = bool
  default     = true
}

variable "enable_backup" {
  description = "Enable backup features"
  type        = bool
  default     = false
}

variable "password_length" {
  description = "Length of generated passwords"
  type        = number
  default     = 16
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project = "demo"
    Owner   = "platform-team"
  }
}

variable "allowed_cidrs" {
  description = "List of allowed CIDR blocks"
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "application_ports" {
  description = "List of application ports"
  type        = list(number)
  default     = [80, 443, 8080, 8443]
}

variable "service_names" {
  description = "List of service names"
  type        = list(string)
  default     = ["web", "api", "database", "cache", "queue"]
}

variable "database_config" {
  description = "Database configuration"
  type = object({
    engine      = string
    version     = string
    multi_az    = bool
    storage_gb  = number
  })
  default = {
    engine      = "postgres"
    version     = "14.9"
    multi_az    = false
    storage_gb  = 100
  }
}

variable "notification_email" {
  description = "Email for notifications"
  type        = string
  default     = "admin@example.com"
}

variable "retention_days" {
  description = "Data retention period in days"
  type        = number
  default     = 30
}

variable "max_capacity" {
  description = "Maximum capacity for scaling"
  type        = number
  default     = 10
}

variable "min_capacity" {
  description = "Minimum capacity for scaling"
  type        = number
  default     = 1
}

variable "ssl_certificate_arn" {
  description = "SSL certificate ARN"
  type        = string
  default     = "arn:aws:acm:us-west-2:123456789012:certificate/example"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "backup_schedule" {
  description = "Backup schedule expression"
  type        = string
  default     = "cron(0 2 * * ? *)"
}

variable "monitoring_interval" {
  description = "Monitoring interval in seconds"
  type        = number
  default     = 300
}

variable "log_level" {
  description = "Application log level"
  type        = string
  default     = "INFO"
  validation {
    condition     = contains(["DEBUG", "INFO", "WARN", "ERROR"], var.log_level)
    error_message = "Log level must be one of: DEBUG, INFO, WARN, ERROR."
  }
}

# =============================================================================
# RESOURCES (20+)
# =============================================================================

# Random resources for generating various values
resource "random_id" "deployment_id" {
  byte_length = 8
  keepers = {
    project = var.project_name
    env     = var.environment
  }
}

resource "random_pet" "cluster_name" {
  length    = 3
  separator = "-"
  keepers = {
    project = var.project_name
  }
}

resource "random_password" "admin_password" {
  length  = var.password_length
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "random_password" "database_password" {
  length  = 20
  special = false
  keepers = {
    db_engine = var.database_config.engine
  }
}

resource "random_string" "session_secret" {
  length  = 32
  special = false
  upper   = true
  lower   = true
  numeric = true
}

resource "random_uuid" "api_key" {
  keepers = {
    project = var.project_name
    team    = var.team_name
  }
}

resource "random_integer" "port_offset" {
  min = 1000
  max = 9999
  keepers = {
    service = "web-service"
  }
}

resource "random_shuffle" "availability_zones" {
  input = var.availability_zones
  keepers = {
    deployment_id = random_id.deployment_id.hex
  }
}

# Time resources for managing timestamps and delays
resource "time_static" "deployment_timestamp" {
  triggers = {
    deployment_id = random_id.deployment_id.hex
  }
}

resource "time_sleep" "initialization_delay" {
  create_duration = "30s"
  depends_on      = [time_static.deployment_timestamp]
}

resource "time_rotating" "certificate_rotation" {
  rotation_days = 90
  triggers = {
    certificate_arn = var.ssl_certificate_arn
  }
}

# Terraform data resources for lifecycle management
resource "terraform_data" "configuration_trigger" {
  triggers_replace = {
    project_name = var.project_name
    environment  = var.environment
    config_hash  = md5(jsonencode(var.tags))
  }
}

resource "terraform_data" "database_lifecycle" {
  triggers_replace = {
    engine     = var.database_config.engine
    version    = var.database_config.version
    storage_gb = var.database_config.storage_gb
  }
  
  provisioner "local-exec" {
    command = "echo 'Database configuration updated at ${timestamp()}'"
  }
}

resource "terraform_data" "monitoring_setup" {
  count = var.enable_monitoring ? 1 : 0
  
  triggers_replace = {
    monitoring_enabled = var.enable_monitoring
    interval          = var.monitoring_interval
  }
  
  provisioner "local-exec" {
    command = "echo 'Monitoring setup completed for ${var.project_name}'"
  }
}

resource "terraform_data" "logging_setup" {
  count = var.enable_logging ? 1 : 0
  
  triggers_replace = {
    logging_enabled = var.enable_logging
    log_level      = var.log_level
  }
}

resource "terraform_data" "backup_setup" {
  count = var.enable_backup ? 1 : 0
  
  triggers_replace = {
    backup_enabled = var.enable_backup
    schedule      = var.backup_schedule
    retention     = var.retention_days
  }
}

# Local file resources for configuration management
resource "local_file" "deployment_config" {
  filename = "${path.module}/outputs/deployment-${random_id.deployment_id.hex}.json"
  content = jsonencode({
    deployment_id = random_id.deployment_id.hex
    project_name  = var.project_name
    environment   = var.environment
    timestamp     = time_static.deployment_timestamp.rfc3339
    cluster_name  = random_pet.cluster_name.id
  })
}

resource "local_file" "service_discovery" {
  filename = "${path.module}/outputs/services.yaml"
  content = yamlencode({
    services = [
      for idx, service in var.service_names : {
        name = service
        port = var.application_ports[idx % length(var.application_ports)]
        zone = random_shuffle.availability_zones.result[idx % length(random_shuffle.availability_zones.result)]
      }
    ]
  })
}

resource "local_sensitive_file" "secrets" {
  filename = "${path.module}/outputs/secrets.env"
  content = <<-EOT
    ADMIN_PASSWORD=${random_password.admin_password.result}
    DATABASE_PASSWORD=${random_password.database_password.result}
    SESSION_SECRET=${random_string.session_secret.result}
    API_KEY=${random_uuid.api_key.result}
  EOT
}

resource "local_file" "network_config" {
  filename = "${path.module}/outputs/network.conf"
  content = <<-EOT
    # Network Configuration
    VPC_CIDR=${var.vpc_cidr}
    REGION=${var.region}
    ALLOWED_CIDRS=${join(",", var.allowed_cidrs)}
    PORTS=${join(",", var.application_ports)}
  EOT
}

# Additional terraform_data resources for various scenarios
resource "terraform_data" "scaling_config" {
  triggers_replace = {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
    instance_count = var.instance_count
  }
}

resource "terraform_data" "security_scan" {
  triggers_replace = {
    config_hash = md5(jsonencode({
      cidrs = var.allowed_cidrs
      ports = var.application_ports
    }))
  }
  
  provisioner "local-exec" {
    command = "echo 'Security scan completed at ${timestamp()}'"
  }
}

resource "terraform_data" "compliance_check" {
  triggers_replace = {
    project      = var.project_name
    environment  = var.environment
    backup_enabled = var.enable_backup
    monitoring_enabled = var.enable_monitoring
  }
}

resource "terraform_data" "performance_baseline" {
  triggers_replace = {
    instance_count = var.instance_count
    monitoring_interval = var.monitoring_interval
  }
}

resource "terraform_data" "cost_optimization" {
  triggers_replace = {
    environment = var.environment
    instance_count = var.instance_count
    storage_gb = var.database_config.storage_gb
  }
}

# =============================================================================
# OUTPUTS (20+)
# =============================================================================

output "deployment_id" {
  description = "Unique deployment identifier"
  value       = random_id.deployment_id.hex
}

output "cluster_name" {
  description = "Generated cluster name"
  value       = random_pet.cluster_name.id
}

output "admin_password" {
  description = "Generated admin password"
  value       = random_password.admin_password.result
  sensitive   = true
}

output "database_password" {
  description = "Generated database password"
  value       = random_password.database_password.result
  sensitive   = true
}

output "session_secret" {
  description = "Generated session secret"
  value       = random_string.session_secret.result
  sensitive   = true
}

output "api_key" {
  description = "Generated API key UUID"
  value       = random_uuid.api_key.result
  sensitive   = true
}

output "port_offset" {
  description = "Random port offset for services"
  value       = random_integer.port_offset.result
}

output "selected_availability_zones" {
  description = "Shuffled list of availability zones"
  value       = random_shuffle.availability_zones.result
}

output "deployment_timestamp" {
  description = "Deployment creation timestamp"
  value       = time_static.deployment_timestamp.rfc3339
}

output "certificate_rotation_time" {
  description = "Next certificate rotation time"
  value       = time_rotating.certificate_rotation.rotation_rfc3339
}

output "project_configuration" {
  description = "Project configuration summary"
  value = {
    name        = var.project_name
    environment = var.environment
    team        = var.team_name
    region      = var.region
  }
}

output "feature_flags" {
  description = "Enabled feature flags"
  value = {
    monitoring = var.enable_monitoring
    logging    = var.enable_logging
    backup     = var.enable_backup
  }
}

output "network_settings" {
  description = "Network configuration settings"
  value = {
    vpc_cidr          = var.vpc_cidr
    allowed_cidrs     = var.allowed_cidrs
    application_ports = var.application_ports
  }
}

output "database_configuration" {
  description = "Database configuration details"
  value = {
    engine     = var.database_config.engine
    version    = var.database_config.version
    multi_az   = var.database_config.multi_az
    storage_gb = var.database_config.storage_gb
  }
}

output "scaling_parameters" {
  description = "Auto-scaling configuration"
  value = {
    min_capacity     = var.min_capacity
    max_capacity     = var.max_capacity
    current_count    = var.instance_count
  }
}

output "service_mapping" {
  description = "Service to availability zone mapping"
  value = {
    for idx, service in var.service_names : service => {
      port = var.application_ports[idx % length(var.application_ports)]
      zone = random_shuffle.availability_zones.result[idx % length(random_shuffle.availability_zones.result)]
    }
  }
}

output "monitoring_configuration" {
  description = "Monitoring system configuration"
  value = {
    enabled           = var.enable_monitoring
    interval_seconds  = var.monitoring_interval
    retention_days    = var.retention_days
    notification_email = var.notification_email
  }
}

output "backup_settings" {
  description = "Backup configuration settings"
  value = {
    enabled       = var.enable_backup
    schedule      = var.backup_schedule
    retention_days = var.retention_days
  }
}

output "security_configuration" {
  description = "Security-related configuration"
  value = {
    ssl_certificate_arn = var.ssl_certificate_arn
    allowed_cidrs      = var.allowed_cidrs
    log_level          = var.log_level
  }
}

output "resource_tags" {
  description = "Common resource tags"
  value = merge(var.tags, {
    DeploymentId = random_id.deployment_id.hex
    ClusterName  = random_pet.cluster_name.id
    Timestamp    = time_static.deployment_timestamp.rfc3339
  })
}

output "file_outputs" {
  description = "Generated configuration files"
  value = {
    deployment_config = local_file.deployment_config.filename
    service_discovery = local_file.service_discovery.filename
    secrets_file     = local_sensitive_file.secrets.filename
    network_config   = local_file.network_config.filename
  }
}

output "deployment_summary" {
  description = "Complete deployment summary"
  value = {
    id               = random_id.deployment_id.hex
    name             = random_pet.cluster_name.id
    timestamp        = time_static.deployment_timestamp.rfc3339
    environment      = var.environment
    region           = var.region
    instance_count   = var.instance_count
    features_enabled = [
      for feature, enabled in {
        monitoring = var.enable_monitoring
        logging    = var.enable_logging
        backup     = var.enable_backup
      } : feature if enabled
    ]
  }
}

output "generated_values_summary" {
  description = "Summary of all generated random values"
  value = {
    deployment_id = random_id.deployment_id.hex
    cluster_name  = random_pet.cluster_name.id
    port_offset   = random_integer.port_offset.result
    selected_azs  = random_shuffle.availability_zones.result
    has_passwords = true
    has_api_key   = true
    has_session_secret = true
  }
}

output "compliance_status" {
  description = "Compliance and governance status"
  value = {
    backup_configured     = var.enable_backup
    monitoring_enabled   = var.enable_monitoring
    logging_enabled      = var.enable_logging
    ssl_configured       = var.ssl_certificate_arn != ""
    retention_compliant  = var.retention_days >= 30
    password_policy_met  = var.password_length >= 12
  }
}
