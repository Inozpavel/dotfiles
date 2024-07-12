#!/bin/zsh

PACKAGES=(
btop
zsh
curl
wget
git
neofetch
wezterm
bluez
bluez-tools
stow
ttf-jetbrains-mono-nerd
ttf-firacode-nerd
)

DEV_PACKAGES=(
rust
bat
lsd
ripgrep
fd
fzf
zoxide       # https://github.com/ajeetdsouza/zoxide
)

#$RUST_TOOLS

#GNOME_PACKAGES=(
#"gdm"
#"gnome"
#"gnome-bluetooth-3.0"
#)

# Gnome extensions
# App indicator and LStatusNotifierItem Support
# ArcMenu
# Blur my shell
# Caffeine
# Clipboard indicator / Pano
# Compiz alike magic lamp effect
# Compiz windows effect
# Dash to Dock
# Desktop Cube
# Fly-Pie
# Hide Universal Access
# Impatience
# Logo menu
# Quick Setting Tweaker
# Space bar
# Tweaks & extensions in system menu
# Vitals


USER_HOME=$(eval echo ~"${SUDO_USER}")

main() {
  echo "Installation starting..."

  update_sources_and_installed_packages
  echo
  install_packages
  echo
  install_dev_packages
  echo
  change_shell_to_zsh
  echo
  install_wezterm
  echo
  install_rust
  echo
  link_configs

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

link_configs() {
  sh -c 'cd dotfiles && sudo stow --adopt ignore=".idea|install\.sh" -vRt ~ .'
}

change_shell_to_zsh() {
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

check_command_exists() {
  if ! [[ $# -eq 1 ]]; then
    >&2 echo "Internal script error: expected 1 arg in check_command_exists"
    exit 1
  fi
  command -v $1 >/dev/null
  return $?
}

main "$@"|| exit 1

