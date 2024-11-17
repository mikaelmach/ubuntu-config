#!/bin/bash

set -Eeuo pipefail


#######################################
# setup git ssh key
# Globals:
# Arguments:
#   None
#######################################
function setup_git_ssh_key() {

	# read Git user email for keygen
	read -p "Enter Git User Email: " git_user_email

	# wait for confirmation
	read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

	# generate key for given user email
	ssh-keygen -q -t ed25519 -N '' -f ~/.ssh/id_ed25519 -C "$git_user_email"

	# initiate ssh-agent
	eval "$(ssh-agent -s)"

	# add ssh generated ssh key
	ssh-add ~/.ssh/id_ed25519

	# print ssh pub key for adding it to github
	cat ~/.ssh/id_ed25519.pub
  }

setup_git_ssh_key
