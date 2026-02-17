#!/bin/bash
# Setup script for module initialization
echo "Running setup script..."
echo "This is a non-Terraform file that should persist between plan and apply"

# Create some test data
mkdir -p ./output
echo "Setup completed at $(date)" > ./output/setup.log
