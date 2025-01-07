#!/bin/bash

#############################################################################
# [Setup]

# Define the log file globally
pc_name=$(hostname)
username=$(whoami)
current_date=$(date +%Y-%m-%d)
log_file="${pc_name}_${username}_4c_install_poetry_${current_date}.log"

touch "$log_file"

#############################################################################
# [Functions]

H1() {
    echo ""
    echo -e "\033[1m$1\033[0m" | tee -a "$log_file"
}

log() {
    local message="$(date +'%Y-%m-%d %H:%M:%S') - $1"
    echo "$message" | tee -a "$log_file"
}

# Redirect stdout and stderr to the log file
exec > >(while read -r line; do log  "INFO : $line"; done)
exec 2> >(while read -r line; do log "ERROR: $line"; done)

#############################################################################
# [Main]

H1 "# Install Poetry"
# option 2: curl -sSL https://install.python-poetry.org | python3 -
sudo apt install python3-poetry 

H1 "# Add Poetry to PATH (if not already added)"

# Check if $HOME/.local/bin is already in the PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

H1 "# Verify install "

which poetry
poetry --version
