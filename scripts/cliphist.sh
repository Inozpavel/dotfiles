#!/usr/bin/bash

case "$1" in
  d) cliphist list | rofi -dmenu -replace | cliphist delete ;;
  w) cliphist wipe ;;
  *) cliphist list | rofi -dmenu -replace -config ~/dotfiles/.config/rofi/config-cliphist.rasi  | cliphist decode | wl-copy ;;
esac