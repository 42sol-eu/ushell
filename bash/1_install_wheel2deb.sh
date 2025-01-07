#!/bin/bash

install_with_pipx() {
    sudo apt install python3 pipx
    which pipx; pipx --version
    pipx install --force wheel2deb


    ## Check if the installation was successful
    which wheel2deb
wheel2deb version 
}

install_with_deb() {
    # see: https://docs.wakemeops.com/usage/
    curl -sSL https://raw.githubusercontent.com/upciti/wakemeops/main/assets/install_repository | sudo bash
    sudo apt-get update
    sudo apt install wheel2deb
    # sudo apt install gotop diskonaut elvish chezmoi cheat 

    ## Check if the installation was successful
    which /usr/bin/wheel2deb
    /usr/bin/wheel2deb version 
}



PARSED_OPTIONS=$(getopt -o pd --long help,version,pipx,deb -- "$@")
if [ $? -ne 0 ]; then
  exit 1
fi

eval set -- "$PARSED_OPTIONS"

while true; do
  case "$1" in
    -p) install_with_pipx; shift ;;
    -d) install_with_deb; shift ;;
    --help) echo "\n -p/--pipx: install with pipx\n -d/--deb: install with debian."; shift ;;
    --version) echo "Option --version"; shift ;;
    --pipx) install_with_pipx; shift ;;
    --deb) install_with_deb; shift ;;
    --) shift; break ;;
    *) echo "Invalid option"; exit 1 ;;
  esac
done


