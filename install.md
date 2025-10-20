> [!WARNING]
> Используя это руководство, вы получите минимальную установку `Arch Linux` с настроенным сетевым соединением только через `WiFi`. Руководство актуально только для машин с `UEFI`. Предполагается, что `Arch Linux` будет единственной системой на машине. Все данные на выбранном диске будут потеряны.
### Архитектура системы
- __Прошивка:__  `UEFI` (исключительно)
- __Загрузчик:__  `systemd-boot`
- __Сетевой стек:__  
	- __DNS:__ `systemd-resolved`
	- __WiFi:__ `iwd` со встроенным `DHCP-клиентом`
	- __Ethernet:__ отсутствует (для поддержки добавьте и настройте `systemd-networkd` или просто используйте `Network Manager`)
### Cтруктура разделов
```text
/dev/nvme0n1
├── /dev/nvme0n1p1 → /boot/efi (FAT32, 1 ГБ, ESP)
├── /dev/nvme0n1p2 → / (ext4, мимнимум 30 ГБ)
├── /dev/nvme0n1p3 → swap (равен объёму RAM, гибернация)
└── /dev/nvme0n1p4 → /home (ext4, оставшееся пространство)
```
## 1. Подготовка установочного носителя
#### 1.1. Загрузка установочного образа
Загрузите с официального сайта [archlinux.org/download](https://archlinux.org/download/):
-  ISO образ (далее `archlinux.iso`)
- PGP подпись (PGP signature, далее `archlinux.iso.sig`)
#### 1.2. Проверка подписи
1. **Импорт PGP-ключа:**
```bash
# Получаем открытый ключ Pierre Schmitz(подписывает образ) через WKD
gpg --auto-key-locate clear,wkd -v --locate-external-key pierre@archlinux.org
```
2. **Верификация отпечатка ключа:**  
_Вручную убедитесь, что отпечаток импортированного ключа совпадает с опубликованным на [archlinux.org/people/developers](https://archlinux.org/people/developers/#pierre)(Pierre Schmitz)_
```bash
gpg --list-keys --with-fingerprint pierre@archlinux.org
```
3. **Проверка подписи образа:**
После того как ключ импортирован и сверен, проверьте подпись образа:
```bash
gpg --verify archlinux.iso.sig archlinux.iso
```
**Успешный вывод:** `Good signature from "Pierre Schmitz <pierre@archlinux.org>"`. 
#### 1.3. Проверка хэш-суммы
Сравните контрольную сумму образа с официальной представленной на сайте.
```bash
echo "СКОПИРОВАННАЯ_ХЭШ_СУММА  archlinux" | sha256sum -c -
```
**Успешный вывод**: `archlinux: OK`
#### 1.4. Создание установочного носителя
```bash
# 1. Идентифицируйте целевой накопитель
lsblk
# 2. Запись образа (ЗАМЕНИТЕ /dev/sdX)
sudo dd if=archlinux-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync
```
_Примечание: также можно использовать более дружелюбные утилиты, такие как Balena Etcher или Ventoy._
## 2.  Предустановочная подготовка
#### 2.1.  Загрузка live-окружения(в UEFI)
Перед загрузкой убедитесь:
- `Secure Boot` - отключен
- Установлен приоритет загрузки с установочного носителя

Для подтверждения проверьте режим загрузки live-среды:
```bash
# Если команда выводит список переменных - система загрузилась в UEFI режиме.
ls /sys/firmware/efi/efivars
# или можете использовать
evifar -l
```
#### 2.2. Настройка сети
Live-окружение использует `systemd-networkd` и `systemd-resolved`. поэтому как правило:
- для проводного интернета - достаточно просто подключить `Ethernet` кабель
- для `WiFi` - используйте `iwctl` и войдите в сеть (на забываем про возможную блокировку `rfkill`)
- для мобильного интернета - используем `mmcli`

**Пример для WiFi:**
```bash
# Найдите беспроводные интерфейсы
iwctl device list
# Сканируйте сети
iwctl station wlan0 scan
iwctl station wlan0 get-networks
# Подключитесь и введите пароль при запросе
iwctl station wlan0 connect "SSID"

# Если интерфейс заблокирован (soft blocked), разблокируйте
rfkill unblock wlan

# Тестируем соединение
ping archlinux.org
```

#### 2.3. Раскладка клавиатуры и шрифт (опционально)
Если вам нужна русская раскладка в процессе установки:
```bash
# Добавляем русскую раскладку
loadkeys ru
# добавляем кириллический шрифт для консоли
setfont cyr-sun16
```
Переключение на русскую раскладку происходит по `Shift`+`Ctrl`. 
#### 2.4. Синхронизация аппаратных часов
_Корректное время критично для работы с TLS (HTTPS)  при установке пакетов._
В live-окружении по умолчанию активен демон `systemd-timesyncd`, который выполнит синхронизацию времени автоматически после подключения к интернету.
```bash
# Проверить статус синхронизации
timedatectl
# Если NTP не активирован или время не синхронизировано
timedatectl set-ntp true
```
_Повторно выполните `timedatectl` для подтверждения статуса `System clock synchronized: yes`._
## 3. Разметка и подготовка диска
#### 3.1.  Создание разделов
```bash
# Очистка диска (ВНИМАНИЕ: УДАЛЯЕТ ВСЕ ДАННЫЕ)
wipefs -a /dev/nvme0n1

# Создание разделов через parted
parted /dev/nvme0n1 --script mklabel gpt
parted /dev/nvme0n1 --script mkpart ESP fat32 1MiB 1025MiB
parted /dev/nvme0n1 --script set 1 esp on
parted /dev/nvme0n1 --script mkpart primary ext4 1025MiB 33GiB
parted /dev/nvme0n1 --script mkpart primary linux-swap 33GiB 49GiB
parted /dev/nvme0n1 --script mkpart primary ext4 49GiB 100%
```
#### 3.2. Форматирование разделов
```
# Файловые системы
mkfs.fat -F32 -n ESP /dev/nvme0n1p1
mkfs.ext4 -L ROOT /dev/nvme0n1p2
mkfs.ext4 -L HOME /dev/nvme0n1p4

# Инициализация swap
mkswap /dev/nvme0n1p3
swapon /dev/nvme0n1p3                      # Активируем swap
```
#### 3.3. Монтирование файловых систем
```bash
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
mount --mkdir /dev/nvme0n1p4 /mnt/home

# Верификация монтирования
findmnt /mnt
```

## 4. Установка базовой системы
#### 4.1. (Опционально) Оптимизация зеркал через Reflector
Перед установкой рекомендуется обновить список зеркал для ускорения загрузки пакетов.  Список зеркал перенесется в устанавливаемую систему.
```bash
# Запускаем reflector для поиска 10 самых актуальных и быстрых зеркал в мире
reflector --latest 10 --sort rate --save /etc/pacman.d/mirrorlist --protocol https --download-timeout 5
```
#### 4.2. Установка основных пакетов
Установите минимальный набор пакетов в смонтированную систему, используя `pacstrap`.
```bash
pacstrap -K /mnt base base-devel linux linux-firmware neovim iwd amd-ucode
# или intel-ucode для процессоров Intel
```

## 5. Системная конфигурация
#### 5.1. Генерация fstab
```bash
# Генерируем файл fstab с опцией -U для использования UUID
genfstab -U /mnt >> /mnt/etc/fstab

# Просмотрите сгенерированный fstab, убедитесь что все нужные разделы присутствуют, UUID указаны корректно, точки монтирования и типы файловых систем правильные
cat /mnt/etc/fstab
```
#### 5.2. Переход в установленную систему (chroot)
```bash
arch-chroot /mnt
```

#### 5.3. Настройка времени и локали

```bash
# Устанавливаем часовой пояс и языковые настройки
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime # Например, Europe/Moscow
# синхронизируем аппаратные часы(в микросхеме UEFI) c системными часами
hwclock --systohc

# Локализация
# Раскомментируйте в файле /etc/locale.gen нужные локали, например:
# en_US.UTF-8 UTF-8 
# ru_RU.UTF-8 UTF-8)
nvim /etc/locale.gen
# генерируем локали
locale-gen

# Устанавливаем основной язык системы
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# (Опционально) Русская расскладка для виртульной консоли(tty)
echo "KEYMAP=ru" > /etc/vconsole.conf
# (Опционально) Добавляем кириллический шрифт для консоли
echo "FONT=cyr-sun16" >> /etc/vconsole.conf
```

#### 5.4. Настройка сети
```bash
# Задание имени компьютера для локальной сети
echo "yourhostname" > /etc/hostname

# Включите необходимые службы
systemctl enable systemd-resolved iwd

# Создаем симлинк для корректной работы systemd-resolved
ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

Настройка `iwd`
```bash
# Базовая конфигурация IWD
mkdir -p /etc/iwd
```
В `/etc/iwd/main.conf` кладем:

```text
[General]
EnableNetworkConfiguration=true

[Network]
NameResolvingService=systemd
```

#### 5.5. Установка и настройка загрузчика
##### 5.5.1 Установка systemd-boot
```bash
bootctl install
```
##### 5.5.2. Конфигурация загрузчика
В основной конфиг `/boot/loader/loader.conf` пишем:
```text
default arch
timeout 3
console-mode max
editor no
```

В загрузочную запись `/boot/loader/entries/arch.conf`:

```text
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=UUID=UUID раздела рут rw
```

**Как узнать `<UUID_раздела_nvme0n1p2>`?**
```bash
blkid -s UUID -o value /dev/nvme0n1p2
```

#### 5.6. Создание пользователей
```bash
# Установите пароль для root
passwd

# Создайте обычного пользователя
useradd -m -G wheel -s /bin/bash username
passwd username

# Настройте sudo для группы wheel
EDITOR=nvim visudo
# Раскомментируйте строку: `%wheel ALL=(ALL:ALL) ALL` 
```
## 6. Завершение установки
```bash
# Выйти из chroot
exit
# Размонтировать разделы
umount -R /mnt
# Перезагрузиться 
reboot
```

## 7. После перезагрузки
#### 7.1.  Сетевое подключение после установки
```bash
# Подключение к WiFi
iwctl station wlan0 connect "SSID" --passphrase "PASSWORD"

# Проверка сети
networkctl status wlan0
resolvectl status
ping -c 3 archlinux.org
```
