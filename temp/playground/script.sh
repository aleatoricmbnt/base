#!/bin/bash

# Define RGB color values
RED=175
GREEN=31
BLUE=240

# ANSI escape codes for bold and RGB color
BOLD="\033[1m"
COLOR="\033[38;2;${RED};${GREEN};${BLUE}m"
RESET="\033[0m"

# Display the highlighted string
echo -e "$${BOLD}$${COLOR}■■■$${RESET}"