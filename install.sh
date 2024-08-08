#!/bin/bash

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
pacman-contrib
)

DEV_PACKAGES=(
rust
bat
lsd
ripgrep
fd
fzf
zoxide       # https://github.com/ajeetdsouza/zoxide
zed
base-devel
)

NVIDIA_PACKAGES=(
  nvidia
  nvidia-settings
  nvidia-utils
)

HYPRLAND_PACKAGES=(
hyprland                         # https://github.com/hyprwm/Hyprland
# hyprpaper                        # https://github.com/hyprwm/hyprpaper
hyprlock                         # https://github.com/hyprwm/hyprlock
wofi
nautilus
mako
python-pywall                    # https://github.com/dylanaraps/pywal
pavucontrol
blueman
grim
slurp                            # https://github.com/emersion/slurp
pinta
xdg-desktop-portal-hyprland
swww                             # https://github.com/LGFae/swww
)

AUR_PACKAGES=(
mission-center                   # https://gitlab.com/mission-center-devs/mission-center
waypaper                         # https://github.com/anufrievroman/waypaper
wlogout                          # https://github.com/ArtsyMacaw/wlogout
)

RESULT_PACKAGES=()

#GNOME_PACKAGES=(
#"gdm"
#"gnome"
#"gnome-bluetooth-3.0"
#)
#v4l2loopback
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

#wallust
USER_HOME=$(eval echo ~"${SUDO_USER}")

main() {
  echo "Installation starting..."

  echo && process_packages
  echo && install_aur_via_paru
  echo && install_aur_packages
  echo && change_shell_to_zsh
  echo && install_rust
  echo && link_configs

  echo "Installation success"
}

#sudo flatpak override --socket=wayland ru.yandex.Browser
process_packages() {
  RESULT_PACKAGES=($(extend_packages RESULT_PACKAGES PACKAGES))
  RESULT_PACKAGES=($(extend_packages RESULT_PACKAGES DEV_PACKAGES))
  RESULT_PACKAGES=($(extend_packages RESULT_PACKAGES HYPRLAND_PACKAGES))

  local nvidia_device=$(lspci | grep -i VGA | grep -i NVIDIA_PACKAGES)

  if [[ $? ]]; then
    echo
    echo "NVIDIA device was found: [ $(echo -n "$nvidia_device" | cut -d ' ' -f 2-) ]"

    # shellcheck disable=SC2034
    RESULT_PACKAGES=($(extend_packages RESULT_PACKAGES NVIDIA_PACKAGES))
    echo "Add to mkinitpcio: MODULES=( nvidia nvidia_modeset nvidia_uvm nvidia_drm ) and run 'sudo mkinitpcio -P'"
  else
    echo "NVIDIA device wasn't found. Skipping packages"
  fi

  install_packages RESULT_PACKAGES
}

install_packages() {
  if [ $# -ne 1 ]; then
      echo "Internal error in install_packages: expected 1 arg, got: $#"
      return 1
  fi
  local -n current_packages=$1

  echo "Installing following packages: [ ${current_packages[@]} ]"
  sudo pacman -Suy --needed "${current_packages[@]}"
}

extend_packages() {
  if [ $# -ne 2 ]; then
      echo "Internal error in install_packages: expected 2 arg, got: $#"
      return 1
  fi
  local -n current_packages=$1
  local -n packages_to_add=$2

  echo "${current_packages[@]} ${packages_to_add[@]}"
}

link_configs() {
  sh -c 'cd dotfiles && sudo stow --adopt ignore=".idea|install\.sh" -vRt ~ .'
}

change_shell_to_zsh() {
  chsh -s "$(which zsh)" "${SUDO_USER:-"$USER"}"
  zsh
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

install_aur_via_paru() {
  echo "Installing paru.."

  git clone https://aur.archlinux.org/paru.git
  sh -c "cd paru && makepkg -si"

  echo "Paru insall completed"
}

install_aur_packages() {
   echo "Installing following packages: [ ${AUR_PACKAGES[@]} ]"
   paru -S "${AUR_PACKAGES[@]}"
}

check_command_exists() {
  if ! [[ $# -eq 1 ]]; then
    >&2 echo "Internal script error: expected 1 arg in check_command_exists, got $#"
    exit 1
  fi
  command -v "$1" >/dev/null
}

main "$@" || exit 1

