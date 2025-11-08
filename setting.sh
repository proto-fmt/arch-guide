#!/bin/bash

set -e

pacman -Syu --noconfirm\
  ### Base packets
  mesa vulkan-radeon \ # grafiks
  pipewire wireplumber pipewire-pulse \ # sound 
  bash-completion man-db openvpn bat lsof tree \
  fzf

  # Wayland Sway
  sway swaybg \ 
  wofi waybar \
  wl-clipboard \
  alacritty ttf-firacode-nerd \
  brightnessctl \
   

# от пользователя sudo
sudo systemctl --user enable --now pipewire wireplumber
