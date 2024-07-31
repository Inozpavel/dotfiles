case "$1" in
  d) ;;
  w) ;;
  *) cliphist list | wofi -S dmenu | cliphist decode | wl-copy ;;
esac