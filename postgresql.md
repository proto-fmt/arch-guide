```shell
sudo pacman -Syu postgresql

# Инициализация кластера базы данных
# Переключитесь на пользователя postgres
sudo -iu postgres

# Инициализируйте БД (указываем локаль)
initdb --locale=en_US.UTF-8 -D /var/lib/postgres/data
# Или используйте системную локаль
# initdb -D /var/lib/postgres/data

# Выйдите из пользователя postgres
exit


# Запустите службу
sudo systemctl start postgresql

# Включите автозагрузку при старте системы
sudo systemctl enable postgresql

# Проверьте статус
sudo systemctl status postgresql
```
