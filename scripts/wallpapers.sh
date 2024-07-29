
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

config_path=~/.config/hypr/hyprpaper.conf
current_config=$(cat $config_path)

wal -s -t -n -i "$wallpaper"

# shellcheck disable=SC2001
updated_config=$(echo -n "${current_config}" | sed -e "s#^\$wallpaper.*=.*#\$wallpaper=$wallpaper#g")
echo -n "$updated_config" > $config_path

sh ~/scripts/waybar/launch.sh

killall hyprpaper
pkill hyprpaper
hyprpaper &
