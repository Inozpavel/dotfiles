#!/bin/sh

export _JAVA_AWT_WM_NOREPARENTING=1
export LIBVA_DRIVER_NAME=nvidia
export CLUTTER_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export WLR_BACKEND=vulkan
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME"=wayland"
export GDK_BACKEND=wayland
export AQ_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark

exec Hyprland
