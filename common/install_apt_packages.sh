#/bin/bash

set -Eeuo pipefail


####################################################
# install apt packages
# Locals:
#  requirements_file
# Arguments:
#   ${1} file containing a list of required packages
####################################################
function install_apt_packages() {
	
  local requirements_file=${1}

  # apt update
  sudo apt update

  # install apt packages from requirements file
  xargs sudo apt install -y -qq <$requirements_file && \
  echo "INFO: installed apt packages from $requirements_file" || \
  echo "ERRROR: installation of install_apt_packages threw an error"
	
  }
