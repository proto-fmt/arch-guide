#!/bin/bash

# Применяем настройки через gsettings
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Noto Sans Mono 11'
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans 12'
gsettings set org.gnome.desktop.interface gtk-theme 'Materia-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface overlay-scrolling false
gsettings set org.gnome.desktop.interface enable-animations false

# Обновляем кэш тем
sudo gtk-update-icon-cache -f /usr/share/icons/Papirus-Dark/ 2>/dev/null || true

echo "GTK настройки применены!"
