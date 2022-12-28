#/bin/bash

set -Eeuo pipefail


#######################################
# install configs
# Globals:
# Arguments:
#   None
#######################################
function setup_git_ssh_key() {

	# Read Git user email for keygen
	read -p "Enter Git User Email: " git_user_email

	# print user email and wait for confirmation
	echo "Git User Email set to: $git_user_email"
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
