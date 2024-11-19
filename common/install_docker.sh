#!/bin/bash

set -Eeuo pipefail


#######################################
# install configs
# Globals:
# Arguments:
#   None
#######################################
#
function prepare_docker() {
    # Add Docker's official GPG key:
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
}


function install_docker() {
    sudo \
        apt \
        install \
        distutils \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-compose \
        docker-buildx-plugin \
        docker-compose-plugin
}
    function configure_docker() {
    # add docker group
    #sudo groupadd docker

    # add current user to docker group
    sudo usermod -aG docker $USER

    # login to new group
    newgrp docker

    # grant permissions to that user
    sudo chmod 666 /var/run/docker.sock

    # restart service
    sudo systemctl restart docker

    # smoke test
    #docker run hello-world

  }

prepare_docker
install_docker
configure_docker
