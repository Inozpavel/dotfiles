#!/usr/bin/bash

killall waybar
pkill waybar

waybar -s ~/.config/waybar/dark.css &