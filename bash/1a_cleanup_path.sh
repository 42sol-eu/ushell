#!/bin/bash

#############################################################################
# [Setup]

# Define the log file globally
pc_name=$(hostname)
username=$(whoami)
current_date=$(date +%Y-%m-%d)
log_file="${pc_name}_${username}_1a_cleanup_path_${current_date}.log"

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

# Function to remove non-existent paths from PATH
clean_path() {
    local new_path=""
    local IFS=":"
    for dir in $PATH; do
        if [ -d "$dir" ]; then
            new_path="${new_path:+$new_path:}$dir"
        fi
    done
    export PATH="$new_path"
}

# Redirect stdout and stderr to the log file
exec > >(while read -r line; do log  "INFO : $line"; done)
exec 2> >(while read -r line; do log "ERROR: $line"; done)

#############################################################################
# [Main]

H1 "# Before:"
echo "Original PATH: $PATH"

H1 "# Execute clean_path:"
# Call the function
clean_path

H1 "# After:"
echo "Cleaned PATH: $PATH"
