wallpaper=~/.config/wallpapers/liquid1.jpg
#wallpaper=~/.config/wallpapers/explorer_orange_sunset.jpg
#wallpaper=~/.config/wallpapers/sundown-over-water.jpg

config_path=~/.config/hypr/hyprpaper.conf
current_config=$(cat $config_path)

wal -c -i $wallpaper

# shellcheck disable=SC2001
updated_config=$(echo -n "${current_config}" | sed -e "s#^\$wallpaper.*=.*#\$wallpaper=$wallpaper#g")
echo -n "$updated_config" > $config_path

sh ~/scripts/waybar/launch.sh

killall hyprpaper
pkill hyprpaper
hyprpaper &
