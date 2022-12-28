#!/bin/bash

set -Eeuo pipefail


source common/install_ohmyzsh.sh
source common/install_powerfonts.sh
source common/install_configs.sh
source common/install_i3.sh
source common/install_terminator.sh
source common/install_fzf.sh
source common/setup_git_ssh_key.sh


#######################################
# main
# Globals:
# Arguments:
#   None
#######################################
function main() {

    install_ohmyzsh
    install_powerfonts
    install_configs
    install_i3
    install_terminator
    install_fzf
    setup_git_ssh_key	
	
  }

main
