#!/usr/bin/bash

rasi_file="$HOME/.config/rofi/current_wallpaper.rasi"

main() {
  if [[ $# -eq 1 ]]; then
    wallpaper=$1
  else
    wallpaper=~/.config/wallpapers/default.jpg
  #  wallpaper=~/.config/wallpapers/hyprland.jpg
  #  wallpaper=~/.config/wallpapers/liquid.jpg
  #  wallpaper=~/.config/wallpapers/explorer_orange_sunset.jpg
  #  wallpaper=~/.config/wallpapers/sundown-over-water.jpg
  fi

  if ! [[ -f "$wallpaper" ]]; then
    echo "Wallpaper with path $wallpaper wasn't found"
    exit 1
  fi

  wal -s -t -n -i "$wallpaper"

  echo "* { current-image: url(\"$wallpaper\", height); }" > "$rasi_file"

  #generate_hyprpaper_config

  sh ~/scripts/waybar/launch.sh 

  swww img "$wallpaper" --transition-type any --transition-fps 90 --transition-duration 3

  #restart_hyprpaper
}

generate_hyprpaper_config() {
  config_path=~/.config/hypr/hyprpaper.conf
  current_config=$(cat $config_path)

  updated_config=$(echo -n "${current_config}" | sed -e "s#^\$wallpaper.*=.*#\$wallpaper=$wallpaper#g")
  echo -n "$updated_config" > $config_path
}

restart_hyprpaper(){
  killall hyprpaper
  pkill hyprpaper
  hyprpaper &
}


main "$@" || exit 1