module "root_01" {
  source = "../.."
}

module "root_02" {
  source = "../.."
}

module "root_03" {
  source = "../.."
}

module "root_04" {
  source = "../.."
}

module "root_05" {
  source = "../.."
}

module "root_06" {
  source = "../.."
}

module "root_07" {
  source = "../.."
}

module "root_08" {
  source = "../.."
}

module "root_09" {
  source = "../.."
}

module "root_10" {
  source = "../.."
}

module "root_11" {
  source = "../.."
}

module "root_12" {
  source = "../.."
}

module "root_13" {
  source = "../.."
}

module "root_14" {
  source = "../.."
}

module "root_15" {
  source = "../.."
}

terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

# Data source that creates multiple files and folders (50-100MB total) - fixed to avoid Windows line endings
data "external" "create_large_files" {
  program = ["bash", "-c", "mkdir -p ./data/logs ./data/config ./data/backups ./data/temp && dd if=/dev/zero of=./data/logs/app.log bs=1M count=10 2>/dev/null && dd if=/dev/zero of=./data/logs/system.log bs=1M count=15 2>/dev/null && dd if=/dev/zero of=./data/backups/backup_01.tar bs=1M count=20 2>/dev/null && dd if=/dev/zero of=./data/backups/backup_02.tar bs=1M count=25 2>/dev/null && for i in {1..10}; do dd if=/dev/zero of=./data/config/config_$i.json bs=1M count=1 2>/dev/null; done && for i in {1..10}; do dd if=/dev/zero of=./data/temp/temp_$i.bin bs=1M count=1 2>/dev/null; done && for i in {1..5}; do head -c 2M </dev/urandom | base64 > ./data/logs/debug_$i.txt; done && total_size=$(du -sb ./data 2>/dev/null | cut -f1) && total_mb=$((total_size / 1024 / 1024)) && file_count=$(find ./data -type f | wc -l) && echo \"{\\\"status\\\":\\\"created\\\",\\\"total_size_mb\\\":\\\"$total_mb\\\",\\\"file_count\\\":\\\"$file_count\\\",\\\"base_dir\\\":\\\"./data\\\"}\""]
}
