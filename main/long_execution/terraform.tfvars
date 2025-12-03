# Terraform variables for long-running execution testing
# Adjust these values based on your grace shutdown timeout requirements

# Duration for sleep operations (in seconds)
# Set this to be longer than your expected grace shutdown timeout
sleep_duration = 900  # 15 minutes

# Number of resources to create
# Higher numbers increase planning time and resource creation time
resource_count = 100

# Enable external data source with long execution
# This adds additional complexity and execution time
enable_external_data = true