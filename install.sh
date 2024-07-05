#!/bin/zsh

PACKAGES=(
"btop"
"zsh"
"bat"
"lsd"
"curl"
"wget"
"git"
"neofetch"
"wezterm"
)

#GNOME_PACKAGES=(
#"gdm"
#"gnome"
#)

# Gnome extensions
# arcmenu
# vitals
# blur my shell
# clipboard indicator
# pano
# space bar
# tweaks and extensions in system menu
# dash to dock
# desktop cube
# logo menu

main() {
  echo "Installation starting..."

  update_sources_and_installed_packages
  echo
  add_packages
  echo
  install_oh_my_zsh
  echo
  install_wezterm
  echo

  echo "Installation success"
}

update_sources_and_installed_packages() {
  echo "Updating packages..."
  sudo pacman -Suy
  echo "Package update complete"
}

add_packages() {
  echo "Installing required packages..."
  for package in "${PACKAGES[@]}"; do
    yes | sudo pacman -S --needed "${package}"
  done
   echo "Installing required packages completed"
}

install_oh_my_zsh() {
  USER_HOME=$(eval echo ~"${SUDO_USER}")
  export ZSH="${USER_HOME}/.oh-my-zsh"
  export ZSH_CUSTOM="${ZSH}/custom"
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

  cp "$(dirname "$0")/.zshrc" "$USER_HOME/.zshrc"
  LSD_CONFIG_DIRECTORY="$USER_HOME/.config/lsd"
  mkdir -p "${LSD_CONFIG_DIRECTORY}"
  cp "$(dirname "$0")/lsd_config.yaml" "${LSD_CONFIG_DIRECTORY}/config.yaml"

  # plugins

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

  chsh -s "$(which zsh)" "${SUDO_USER:-"$USER"}"
  zsh
}

install_wezterm() {
    USER_HOME=$(eval echo ~"${SUDO_USER}")
    cp "$(dirname "$0")/.wezterm.lua" "${USER_HOME}/.wezterm.lua"
}


main "$@"|| exit 1

