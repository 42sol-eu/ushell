#!/bin/bash

#############################################################################
# [Setup]

# Define the log file globally
pc_name=$(hostname)
username=$(whoami)
current_date=$(date +%Y-%m-%d)
log_file="${pc_name}_${username}_${current_date}.log"

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

H1 "# Git Information:"

which git 
git --version

git config --global --get user.name
git config --global --get user.email

H1 "# All Global Config: (git config --global --list)"

git config --global --list
pause 'Press [Enter] key to continue...'