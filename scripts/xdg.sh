#!/usr/bin/bash

# kill all possible running xdg-desktop-portals
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-kde
killall -e xdg-desktop-portal-lxqt
killall -e xdg-desktop-portal-wlr
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal
sleep 2

# start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
#xwaylandvideobridge &
# start xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
