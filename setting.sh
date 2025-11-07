#!/bin/bash

set -e

pacman -Syu --noconfirm\
  ### Base packets
  mesa vulkan-radeon \
  bash-completion man-db openvpn bat lsof tree \
  fzf

  # Wayland Sway
  sway swaybg \ 
  wofi waybar \
  wl-clipboard \
  alacritty ttf-firacode-nerd \
  brightnessctl \
   
