#!/usr/bin/bash

case "$1" in
  d) cliphist list | rofi -dmenu -replace | cliphist delete ;;
  w) if  [ `echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/config-short.rasi` == "Clear" ]; then
      cliphist wipe
      fi;;
#  *) cliphist list | rofi -dmenu -replace -config ~/dotfiles/.config/rofi/config-cliphist.rasi  | cliphist decode | wl-copy
  *) rofi -modi clipboard:~/.config/rofi/cliphist-rofi-img -show clipboard -show-icons  -config ~/dotfiles/.config/rofi/config-cliphist.rasi;;
esac