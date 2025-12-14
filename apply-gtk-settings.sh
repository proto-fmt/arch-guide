# Устанавливаем шрифты
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Noto Sans Mono 11'
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans 12'

# Устанавливаем рендеринг шрифтов
gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
gsettings set org.gnome.desktop.interface font-hinting 'slight'
gsettings set org.gnome.desktop.interface font-rgba-order 'rgb'

# Темная тема
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Materia-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

# Отключаем анимации и горячие углы (опционально)
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Настраиваем скроллбары
gsettings set org.gnome.desktop.interface overlay-scrolling false
