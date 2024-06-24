#!/bin/zsh

ALIASES=(
"ll=\"ls -al\""
"grep=\"grep --color=\"auto\"\""
"cls=\"clear\""
)

TERMINAL_FILE="$HOME/.zshrc"

addAliases(){
  for als in "${ALIASES[@]}"
  do
    line="alias ${als}"
    if ! grep -q "$line" "$TERMINAL_FILE"
    then
      echo "Adding alias ${als}"
      echo "Line $line"
      echo "$line" >> "$TERMINAL_FILE"
    fi
  done
}

echo "Installation starting"

addAliases

echo "Installation success"