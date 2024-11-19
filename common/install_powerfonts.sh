#/bin/bash

set -Eeuo pipefail

# other choices of nerdfonts, add to $fonts at will
  # BitstreamVeraSansMono
  # CascadiaCode
  # CodeNewRoman
  # Go-Mono
  # Hack
  # Hermit
  # JetBrainsMono
  # Meslo
  # Noto
  # Overpass
  # ProggyClean
  # RobotoMono
  # SourceCodePro
  # SpaceMono
  # Ubuntu

#######################################
# install fonts
# Globals: none
# Arguments: none
#   None
#######################################
function install_powerfonts() {

    declare -a fonts=(
      DroidSansMono
      FiraCode
      FiraMono
      UbuntuMono
    )

    # fetch latest version
    local version=$(curl -s 'https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest' | jq -r '.name')
    if [ -z "$version" ] || [ "$version" = "null" ]; then
      version="v3.2.1"
    fi
    echo "latest version: $version"

    # set dir for fonts
    local fonts_dir="${HOME}/.local/share/fonts"
    #fonts_dir="/usr/share/fonts"

    if [[ ! -d "$fonts_dir" ]]; then
      mkdir -p "$fonts_dir"
    fi

    # get fonts from remote repo
    for font in "${fonts[@]}"; do
      local zip_file="${font}.zip"
      local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/${zip_file}"
      echo "Downloading $download_url"
      wget "$download_url"

      # install fonts to fonts dir
      unzip -o "$zip_file" -d "$fonts_dir"  # Added the -o option here to allow replacing
      rm "$zip_file"

    done

    # get rid of unused fonts
    find "$fonts_dir" -name 'Windows Compatible' -delete

    # fc-cache scans the font directories on the system and builds font information cache files for applications using fontconfig for their font handling.
    fc-cache -fv
  }
