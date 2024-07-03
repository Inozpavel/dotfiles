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
    yes | sudo pacman -S "${package}"
  done
   echo "Installing required packages completed"
}

install_oh_my_zsh(){
  local USER_HOME
  local ZSH_CUSTOM
  yes | sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

  USER_HOME=$(eval echo ~"${SUDO_USER}")

  cp "$(dirname "$0")"/.zshrc "$USER_HOME/.zshrc"

  # plugins
  ZSH_CUSTOM="${USER_HOME}/.oh-my-zsh/custom"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

  chsh -s "$(which zsh)" "${SUDO_USER:-"$USER"}"
}


main "$@"|| exit 1

