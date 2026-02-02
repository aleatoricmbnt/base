terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

# Trigger resource to force recreation on each apply
resource "terraform_data" "force_recreate" {
  input = timestamp()
}

# Step 1: Create directory structure
data "external" "create_directories" {
  program = ["bash", "-c", "mkdir -p ./data/logs ./data/config ./data/backups ./data/temp && echo '{\"status\":\"directories_created\"}'"]
}

# Step 2: Create 10MB log file
data "external" "create_app_log" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/logs/app.log bs=1M count=10 2>/dev/null && echo '{\"status\":\"app_log_created\",\"size_mb\":\"10\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 3: Create 15MB system log file
data "external" "create_system_log" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/logs/system.log bs=1M count=15 2>/dev/null && echo '{\"status\":\"system_log_created\",\"size_mb\":\"15\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 4: Create 20MB backup file
data "external" "create_backup_01" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/backups/backup_01.tar bs=1M count=20 2>/dev/null && echo '{\"status\":\"backup_01_created\",\"size_mb\":\"20\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 5: Create 25MB backup file
data "external" "create_backup_02" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/backups/backup_02.tar bs=1M count=25 2>/dev/null && echo '{\"status\":\"backup_02_created\",\"size_mb\":\"25\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 6: Create 10 config files (1MB each)
data "external" "create_config_files" {
  program = ["bash", "-c", "for i in {1..10}; do dd if=/dev/zero of=./data/config/config_$i.json bs=1M count=1 2>/dev/null; done && echo '{\"status\":\"config_files_created\",\"count\":\"10\",\"size_mb\":\"10\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 7: Create 10 temp files (1MB each)
data "external" "create_temp_files" {
  program = ["bash", "-c", "for i in {1..10}; do dd if=/dev/zero of=./data/temp/temp_$i.bin bs=1M count=1 2>/dev/null; done && echo '{\"status\":\"temp_files_created\",\"count\":\"10\",\"size_mb\":\"10\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 8: Create 5 debug files with random data (2MB each)
data "external" "create_debug_files" {
  program = ["bash", "-c", "for i in {1..5}; do head -c 2M </dev/urandom | base64 > ./data/logs/debug_$i.txt; done && echo '{\"status\":\"debug_files_created\",\"count\":\"5\",\"size_mb\":\"10\"}'"]
  
  depends_on = [data.external.create_directories]
}

# Step 9: Calculate total size
data "external" "calculate_total" {
  program = ["bash", "-c", "total_size=$(du -sb ./data 2>/dev/null | cut -f1) && total_mb=$((total_size / 1024 / 1024)) && file_count=$(find ./data -type f | wc -l) && echo \"{\\\"status\\\":\\\"calculated\\\",\\\"total_size_mb\\\":\\\"$total_mb\\\",\\\"file_count\\\":\\\"$file_count\\\"}\""]
  
  depends_on = [
    data.external.create_app_log,
    data.external.create_system_log,
    data.external.create_backup_01,
    data.external.create_backup_02,
    data.external.create_config_files,
    data.external.create_temp_files,
    data.external.create_debug_files
  ]
}

# Outputs to verify file creation
output "files_created" {
  value = {
    directories    = data.external.create_directories.result.status
    app_log        = data.external.create_app_log.result.status
    system_log     = data.external.create_system_log.result.status
    backup_01      = data.external.create_backup_01.result.status
    backup_02      = data.external.create_backup_02.result.status
    config_files   = data.external.create_config_files.result.status
    temp_files     = data.external.create_temp_files.result.status
    debug_files    = data.external.create_debug_files.result.status
    total_size_mb  = data.external.calculate_total.result.total_size_mb
    file_count     = data.external.calculate_total.result.file_count
    trigger_time   = terraform_data.force_recreate.input
  }
  description = "Information about created files and folders"
}