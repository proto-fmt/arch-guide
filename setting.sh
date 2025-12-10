### this markdown consist packets for installing in my system

#!/bin/bash

set -e

pacman -Syu --noconfirm\
  ### Base packets
  mesa vulkan-radeon \ # grafics
  pipewire wireplumber pipewire-pulse \ # sound 
  bash-completion man-db openvpn bat lsof tree \
  fzf htop \
  lm_sensors \ 

  # Wayland Hypr
  hyprland \ 
  xdg-desktop-portal-hyprland \
  hyprpolkitagent \
  tlp \
  bluez bluez-utils blueman \
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



   #another 
   perl-image-exiftool mat2 \ # remove meta photo and files

# от пользователя sudo
sudo systemctl --user enable --now pipewire wireplumber

# 
sudo systemctl enable --now bluetooth

sudo systemctl enable --now tlp

sudo sensors-detect --auto

# paru install
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si




