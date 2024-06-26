#!/bin/zsh

PACKAGES=(
"btop"
"zsh"
"bat"
"lsd"
"curl"
"wget"
"git"
)

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
  сp "$(dirname $"0")"/.zshrc "$HOME/.zshrc"
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

  chsh -s "$(which zsh)"
}


main "$@"|| exit 1

