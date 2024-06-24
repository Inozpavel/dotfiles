#!/bin/zsh

ALIASES=(
"ll=\"ls -al\""
"grep=\"grep --color=\"auto\"\""
"cls=\"clear\""
)

PACKAGES=(
"btop"
#"nano"
)

TERMINAL_FILE="$HOME/.zshrc"

main() {
  echo "Installation starting"

  add_aliases
  echo
  update_sources_and_installed_packages
  echo
  add_packages

  echo "Installation success"
}

add_aliases() {
  for als in "${ALIASES[@]}"; do
    local _line="alias ${als}"
    if ! grep -q "$_line" "$TERMINAL_FILE"
    then
      echo "Adding alias ${als}"
      echo "Line $_line"
      echo "$_line" >> "$TERMINAL_FILE"
    fi
  done
}

update_sources_and_installed_packages() {
  echo "Updating packages..."
  sudo pacman -Suy
  echo "Package update complete"
}

add_packages() {
    local _packages_line

    echo "Installing required packages..."
    _packages_line=$(printf " %s" "${PACKAGES[@]}")
    echo "$_packages_line"

#    yes | sudo pacman -S "${_packages_line}"
    sudo pacman -S "${_packages_line}"

    echo "Installing required packages completed"
}


main "$@"|| exit 1

