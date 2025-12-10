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
  # power-profiles-daemon \ change on auto-cpufreq + script brighest
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

sudo sensors-detect --auto

# paru install
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

##### install auto-cpufreq
#
paru -S auto-cpufreq
# 2. Проверяем доступные governors
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
# Пример: conservative ondemand userspace powersave performance schedutil
# 3. Проверяем частоты
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
# Пример: 1400000 1700000 3000000 (1.4, 1.7, 3.0 GHz)

sudo nvim /etc/auto-cpufreq.conf
# конфиг из /etc/auto-cpufreq.conf

# также добавим хук для смены яркости при смене питания
# Создаём файл хука
sudo nano /etc/auto-cpufreq/hook-brightness.sh
# конфиг в /etc/
sudo chmod +x /etc/auto-cpufreq/hook-brightness.sh
# теперь яркост ь должна менятся при смене питания

# install daemon
sudo auto-cpufreq --install
#### end install auto-cpufreq


