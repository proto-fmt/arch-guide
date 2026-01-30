### this markdown consist packets for installing in my system

#!/bin/bash

set -e

pacman -Syu --noconfirm\
  ### Base packets
  mesa vulkan-radeon \ # grafics
  pipewire wireplumber pipewire-pulse \ # sound 
  bash-completion man-db tldr \
  openvpn \
  bat lsof tree \
  fzf htop \
  lm_sensors \ 
  tmux \
  virtualbox virtualbox-host-modules-arch \
  remmina freerdp libvncserver \
  wget curl \

  # Wayland Hypr
  hyprland \ 
  xdg-desktop-portal-hyprland \
  hyprpolkitagent \
  tlp tlp-pd \ # tlp-pd support d-bus and used on waybar in role 'power-profiles-daemon'
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
  qt5-wayland qt6-wayland
  sqlmap \
  exploitdb

  paru -S arc-gtk-theme \ # GTK 2 / 3 /4 ("Noto Sans")
  papirus-icon-theme \ 
  vscodium-bin \
  postman-bin \
  
  brightnessctl \

  # form yazi instruction
  yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick \ #pcmanfm changed on yazi

  
   #another 
   perl-image-exiftool mat2 \ # remove meta photo and files
   openssh \ # ssh
   wireshark-qt traceroute inetutils nmap openbsd-netcat whois bind tcpdump \

   ###  sudo usermod -aG wireshark $USER

   # add black arrch repo
   burpsuite \
   john \ # John the Ripper
   hash-identifier haiti \ # this line it is hash identifers
   seclists \
   openvas \
   

# от пользователя sudo
sudo systemctl --user enable --now pipewire wireplumber

# 
sudo systemctl enable --now bluetooth

sudo systemctl enable --now tlp tlp-pd
sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill.socket 
# 2 string above tlp can auto on and auto off radio modules via bluetooth, wifi and another

sudo sensors-detect --auto

# paru install
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# fot ssh access on github
ssh-keygen -t ed25519 # генериуем открытый и закрытый ключ
# в bashrc запускаем ssh-agent и добавляем ключ



