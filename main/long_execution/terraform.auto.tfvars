# Terraform variables for long-running plan phase testing
# Focused on data sources and network operations

# Duration for sleep operations (in seconds)
sleep_duration = 180  # 3 minutes

# URL for slow download test (use large files to extend download time)
download_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-desktop-amd64.iso"  # ~4GB Ubuntu ISO

# Enable slow download during plan phase
enable_slow_download = true