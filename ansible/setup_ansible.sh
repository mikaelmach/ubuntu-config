#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No Color

# Function to print success messages
success() {
  echo -e "${GREEN}✔ $1${NC}"
}

# Function to print error messages and exit
fail() {
  echo -e "${RED}✖ $1${NC}" >&2
  exit 1
}

# Trap unexpected errors
trap 'fail "An unexpected error occurred. Exiting."' ERR

echo "🔧 Updating system packages..."
sudo apt update && sudo apt upgrade -y || fail "Failed to update system packages"
success "System updated"

echo "📦 Installing required dependencies..."
sudo apt install -y software-properties-common || fail "Failed to install dependencies"
success "Dependencies installed"

echo "📡 Adding Ansible PPA..."
sudo add-apt-repository --yes --update ppa:ansible/ansible || fail "Failed to add Ansible PPA"
success "Ansible PPA added"

echo "🚀 Installing Ansible..."
sudo apt install -y ansible || fail "Failed to install Ansible"
success "Ansible installed"

echo "🔍 Verifying Ansible installation..."
if ansible --version &>/dev/null; then
  ansible --version
  success "Ansible installation verified"
else
  fail "Ansible command not found after installation"
fi

echo -e "${GREEN}🎉 All done! Ansible is ready to use.${NC}"
