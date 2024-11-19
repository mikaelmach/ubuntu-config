#/bin/bash

set -Eeuo pipefail


#######################################
# install configs
# Arguments:
#   None
#######################################
function install_configs() {
    declare -A config_dict=(
                 [vimrc]="$HOME/.vimrc"
                 [zshrc]="$HOME/.zshrc"
                 [bashrc]="$HOME/.bashrc"
                 [i3-config]="$HOME/.config/i3/config"
                 [i3status-config]="$HOME/.config/i3status/config"
               )

    for key in "${!config_dict[@]}"
      do
	      local config_file_source="${pwd}/common/${key}"
	      local config_file_destination=${config_dict[$key]}
	      local config_dirname=$(dirname "${config_file_destination}")

	      # create dir for configfile if not exists
	      mkdir -p $config_dirname

	      # copy config file to destination
	      cp $config_file_source $config_file_destination && \
              echo "INFO: installing $config_file_source in $config_file_destination" || \
	          echo "ERROR: $config_file_source threw and error"
      done
  }
