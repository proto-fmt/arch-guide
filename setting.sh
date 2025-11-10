#!/bin/bash

set -e

pacman -Syu --noconfirm\
  ### Base packets
  mesa vulkan-radeon \ # grafics
  pipewire wireplumber pipewire-pulse \ # sound 
  bash-completion man-db openvpn bat lsof tree \
  fzf \

  # Wayland Hypr
  hyprland \ 
  xdg-desktop-portal-hyprland \
  hyprpolkitagent \
  wofi \
  waybar \
  mako \
  wl-clipboard \
  alacritty \
  ttf-firacode-nerd ttf-jetbrains-mono-nerd noto-fonts noto-fonts-emoji noto-fonts-cjk \
  # noto-fonts-cjk - для иероглифов, китайского, японского прочего языков
  brightnessctl \
  pcmanfm \

   # ttf-fira-code - used in alacritty
   # ttf-jetbrains-mono-nerd - used in hyprland, waybar

# от пользователя sudo
sudo systemctl --user enable --now pipewire wireplumber
