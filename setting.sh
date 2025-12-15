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
  fuzzel \ # (UbuntuMono Nerd Font Mono) 14
  waybar \
  mako \ # (JetBrainsMono Nerd Font Propo) 12
  swayosd \ # OSD window for volume, brigtness
  wl-clipboard \
  alacritty \
  ttf-ubuntu-mono-nerd \ # alacritty (UbuntuMono Nerd Font Mono) 13.5
  ttf-jetbrains-mono-nerd \ # hyprland (JetBrainsMono Nerd Font ),  waybar
  ttf-liberation \ # Arial, Times New Roman, and Courier New
  noto-fonts noto-fonts-emoji noto-fonts-cjk \ 
  # noto-fonts-cjk - для иероглифов, китайского, японского прочего языков

  paru -S arc-gtk-theme \ # GTK 2 / 3 /4 ("Noto Sans")
  papirus-icon-theme \ 
  
  brightnessctl \
  pcmanfm \

  
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




