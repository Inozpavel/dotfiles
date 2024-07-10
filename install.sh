#!/bin/zsh

PACKAGES=(
"btop"
"zsh"
"curl"
"wget"
"git"
"neofetch"
"wezterm"
"bluez"
"bluez-tools"
"stow"
"ttf-jetbrains-mono-nerd"
)

DEV_PACKAGES=(
"rust"
"bat"
"lsd"
"ripgrep"
"fd"
"zoxide"       # https://github.com/ajeetdsouza/zoxide
)

#$RUST_TOOLS

#GNOME_PACKAGES=(
#"gdm"
#"gnome"
#"gnome-bluetooth-3.0"
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

USER_HOME=$(eval echo ~"${SUDO_USER}")

main() {
  echo "Installation starting..."

#  update_sources_and_installed_packages
#  echo
#  install_packages
#  echo
#  install_dev_packages
#  echo
#  install_oh_my_zsh
  echo
#  install_wezterm
  echo
#  install_rust
  echo
#  install_rust_tools
  echo
  set_configs
  echo "Installation success"
}

update_sources_and_installed_packages() {
  echo "Updating packages..."
  sudo pacman -Suy
  echo "Package update complete"
}

install_packages() {
  echo "Installing required packages..."
  for package in "${PACKAGES[@]}"; do
    yes | sudo pacman -S --needed "${package}"
  done
   echo "Installing required packages completed"
}

install_dev_packages() {
  echo "Installing dev packages..."
  for package in "${DEV_PACKAGES[@]}"; do
    yes | sudo pacman -S --needed "${package}"
  done
   echo "Installing dev packages completed"
}

set_configs() {
  sh -c 'cd dotfiles && sudo stow --adopt ignore=".idea|install\.sh" -vRt ~ .'
}

change_shell_to_zsh() {
#  export ZSH="${USER_HOME}/.oh-my-zsh"
#  export ZSH_CUSTOM="${ZSH}/custom"
#  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

  #cp "$(dirname "$0")/.zshrc" "$USER_HOME/.zshrc"
#  LSD_CONFIG_DIRECTORY="$USER_HOME/.config/lsd"
#  mkdir -p "${LSD_CONFIG_DIRECTORY}"
  #cp "$(dirname "$0")/lsd_config.yaml" "${LSD_CONFIG_DIRECTORY}/config.yaml"

  # plugins

#  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
#  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
#  git clone https://github.com/zpm-zsh/clipboard.git "${ZSH_CUSTOM}/plugins/clipboard"  # https://github.com/zpm-zsh/clipboard

  chsh -s "$(which zsh)" "${SUDO_USER:-"$USER"}"
  zsh
}

install_wezterm() {
    echo "Configuring wezterm..."
    cp "$(dirname "$0")/.wezterm.lua" "${USER_HOME}/.wezterm.lua"
    echo "Wezterm configuration completed"
}

install_rust() {

  if ! command -v "cargo" >/dev/null; then
    echo "Installing rust.."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo "Rust install completed"
  else
    echo "Rust is already installed. Skipping..."
  fi

}

install_rust_tools() {
  if ! command -v "cargo" >/dev/null; then
    cargo install $RUST_TOOLS[@]
  fi;
}

check_command_exists() {
  if ! [[ $# -eq 1 ]]; then
    >&2 echo "Internal script error: expected 1 arg in check_command_exists"
    exit 1
  fi
  command -v $1 >/dev/null
  return $?
}

install_zinit() {
}

main "$@"|| exit 1

