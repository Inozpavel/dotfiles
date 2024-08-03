#!/usr/bin/bash

case "$1" in
  d) cliphist list | wofi -S dmenu | cliphist delete ;;
  w) cliphist wipe ;;
  *) cliphist list | wofi -S dmenu --allow-images  | cliphist decode | wl-copy ;;
esac