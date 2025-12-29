# Terragrunt configuration for testing required inputs

terraform {
  source = "."
}

# Intentionally not setting inputs here
# This forces the variables to be provided via Scalr UI
# 
# - environment: string (e.g., "dev")
# - instance_count: number (e.g., 3)
# - enable_monitoring: bool (e.g., true)
# - tags: map(string) (e.g., {"owner": "team-name", "project": "test"})

