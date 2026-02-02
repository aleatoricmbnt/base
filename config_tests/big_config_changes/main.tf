
terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

resource "terraform_data" "name" {
  
}

# Data source that creates multiple files and folders (50-100MB total)
data "external" "create_large_files" {
  program = ["bash", "-c", <<-EOF
# Create directory structure
mkdir -p ./data/logs ./data/config ./data/backups ./data/temp

# Create 10MB file (logs)
dd if=/dev/zero of=./data/logs/app.log bs=1M count=10 2>/dev/null

# Create 15MB file (more logs)
dd if=/dev/zero of=./data/logs/system.log bs=1M count=15 2>/dev/null

# Create 20MB file (backup)
dd if=/dev/zero of=./data/backups/backup_01.tar bs=1M count=20 2>/dev/null

# Create 25MB file (another backup)
dd if=/dev/zero of=./data/backups/backup_02.tar bs=1M count=25 2>/dev/null

# Create multiple smaller files in config (10 files x 1MB = 10MB)
for i in {1..10}; do
  dd if=/dev/zero of=./data/config/config_$i.json bs=1M count=1 2>/dev/null
done

# Create temp files (10 files x 1MB = 10MB)
for i in {1..10}; do
  dd if=/dev/zero of=./data/temp/temp_$i.bin bs=1M count=1 2>/dev/null
done

# Create some text files with random data
for i in {1..5}; do
  head -c 2M </dev/urandom | base64 > ./data/logs/debug_$i.txt
done

# Calculate total size
total_size=$(du -sb ./data 2>/dev/null | cut -f1)
total_mb=$((total_size / 1024 / 1024))
file_count=$(find ./data -type f | wc -l)

echo "{\"status\":\"created\",\"total_size_mb\":\"$total_mb\",\"file_count\":\"$file_count\",\"base_dir\":\"./data\"}"
EOF
  ]
}
