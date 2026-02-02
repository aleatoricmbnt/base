terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

resource "terraform_data" "force_recreate" {
  input = timestamp()
}

data "external" "create_directories" {
  program = ["bash", "-c", "mkdir -p ./data/logs ./data/config ./data/backups ./data/temp && echo '{\"status\":\"directories_created\"}'"]
}

# CHANGED: Much larger files (200MB each)
data "external" "create_backup_01" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/backups/backup_01.tar bs=1M count=200 2>/dev/null && echo '{\"status\":\"backup_01_created\",\"size_mb\":\"200\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "create_backup_02" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/backups/backup_02.tar bs=1M count=200 2>/dev/null && echo '{\"status\":\"backup_02_created\",\"size_mb\":\"200\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "create_backup_03" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/backups/backup_03.tar bs=1M count=200 2>/dev/null && echo '{\"status\":\"backup_03_created\",\"size_mb\":\"200\"}'"]
  depends_on = [data.external.create_directories]
}

# CHANGED: Larger log files (50MB each)
data "external" "create_app_log" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/logs/app.log bs=1M count=50 2>/dev/null && echo '{\"status\":\"app_log_created\",\"size_mb\":\"50\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "create_system_log" {
  program = ["bash", "-c", "dd if=/dev/zero of=./data/logs/system.log bs=1M count=50 2>/dev/null && echo '{\"status\":\"system_log_created\",\"size_mb\":\"50\"}'"]
  depends_on = [data.external.create_directories]
}

# Keep the rest as-is or make them larger too
data "external" "create_config_files" {
  program = ["bash", "-c", "for i in {1..10}; do dd if=/dev/zero of=./data/config/config_$i.json bs=1M count=1 2>/dev/null; done && echo '{\"status\":\"config_files_created\",\"count\":\"10\",\"size_mb\":\"10\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "create_temp_files" {
  program = ["bash", "-c", "for i in {1..10}; do dd if=/dev/zero of=./data/temp/temp_$i.bin bs=1M count=1 2>/dev/null; done && echo '{\"status\":\"temp_files_created\",\"count\":\"10\",\"size_mb\":\"10\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "create_debug_files" {
  program = ["bash", "-c", "for i in {1..5}; do head -c 2M </dev/urandom | base64 > ./data/logs/debug_$i.txt; done && echo '{\"status\":\"debug_files_created\",\"count\":\"5\",\"size_mb\":\"10\"}'"]
  depends_on = [data.external.create_directories]
}

data "external" "calculate_total" {
  program = ["bash", "-c", "total_size=$(du -sb ./data 2>/dev/null | cut -f1) && total_mb=$((total_size / 1024 / 1024)) && file_count=$(find ./data -type f | wc -l) && echo \"{\\\"status\\\":\\\"calculated\\\",\\\"total_size_mb\\\":\\\"$total_mb\\\",\\\"file_count\\\":\\\"$file_count\\\"}\""]
  depends_on = [
    data.external.create_app_log,
    data.external.create_system_log,
    data.external.create_backup_01,
    data.external.create_backup_02,
    data.external.create_backup_03,
    data.external.create_config_files,
    data.external.create_temp_files,
    data.external.create_debug_files
  ]
}

output "files_created" {
  value = {
    directories    = data.external.create_directories.result.status
    app_log        = data.external.create_app_log.result.status
    system_log     = data.external.create_system_log.result.status
    backup_01      = data.external.create_backup_01.result.status
    backup_02      = data.external.create_backup_02.result.status
    backup_03      = data.external.create_backup_03.result.status
    config_files   = data.external.create_config_files.result.status
    temp_files     = data.external.create_temp_files.result.status
    debug_files    = data.external.create_debug_files.result.status
    total_size_mb  = data.external.calculate_total.result.total_size_mb
    file_count     = data.external.calculate_total.result.file_count
  }
}