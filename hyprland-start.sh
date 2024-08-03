#!/bin/sh

export _JAVA_AWT_WM_NOREPARENTING=1
export XCURSOR_SIZE=24
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
#export WLR_DRM_DEVICES=/dev/dri/card1

exec Hyprland
