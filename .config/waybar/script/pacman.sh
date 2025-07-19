#!/bin/bash

# Скрипт для обновления Arch Linux

# Функция для вывода сообщений с цветом
print_message() {
  echo -e "\e[1;32m$1\e[0m"
}

# Функция для обработки ошибок
handle_error() {
  echo -e "\e[1;31mError: $1\e[0m" >&2
  exit 1
}

# Pacman
  print_message " ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄    ▄ "
  print_message "█       █       █       █  █▄█  █       █  █  █ █"
  print_message "█    ▄  █   ▄   █       █       █   ▄   █   █▄█ █"
  print_message "█   █▄█ █  █▄█  █     ▄▄█       █  █▄█  █       █"
  print_message "█    ▄▄▄█       █    █  █       █       █  ▄    █"
  print_message "█   █   █   ▄   █    █▄▄█ ██▄██ █   ▄   █ █ █   █"
  print_message "█▄▄▄█   █▄▄█ █▄▄█▄▄▄▄▄▄▄█▄█   █▄█▄▄█ █▄▄█▄█  █▄▄█"
  sudo pacman -Syu --noconfirm || handle_error "Не удалось обновить пакеты"

# AUR
  print_message " ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄ "  
  print_message "█       █  █ █  █   ▄  █"  
  print_message "█   ▄   █  █ █  █  █ █ █"  
  print_message "█  █▄█  █  █▄█  █   █▄▄█▄" 
  print_message "█       █       █    ▄▄  █"
  print_message "█   ▄   █       █   █  █ █"
  print_message "█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█"
  yay -Syu --noconfirm || echo -e "\e[1;33mПредупреждение: Не удалось обновить AUR пакеты\e[0m"

# Flatpak
  print_message " ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄   ▄ "
  print_message "█       █   █   █      █       █       █      █   █ █ █"
  print_message "█    ▄▄▄█   █   █  ▄   █▄     ▄█    ▄  █  ▄   █   █▄█ █"
  print_message "█   █▄▄▄█   █   █ █▄█  █ █   █ █   █▄█ █ █▄█  █      ▄█"
  print_message "█    ▄▄▄█   █▄▄▄█      █ █   █ █    ▄▄▄█      █     █▄ "
  print_message "█   █   █       █  ▄   █ █   █ █   █   █  ▄   █    ▄  █"
  print_message "█▄▄▄█   █▄▄▄▄▄▄▄█▄█ █▄▄█ █▄▄▄█ █▄▄▄█   █▄█ █▄▄█▄▄▄█ █▄█"
  flatpak update

# Проверка orphaned пакетов (не нужных зависимостей)
#print_message "orphaned check..."
#orphaned=$(pacman -Qdtq)
#if [ -n "$orphaned" ]; then
#  print_message "Найдены orphaned пакеты:"
#  echo "$orphaned"
#  read -p "Удалить эти пакеты? (y/N): " -n 1 -r
#  echo
#  if [[ $REPLY =~ ^[Yy]$ ]]; then
#    pacman -Rns --noconfirm $(pacman -Qdtq) || echo -e "\e[1;33mПредупреждение: Не удалось удалить некоторые orphaned пакеты\e[0m"
#  fi
#else
#  print_message "Orphaned пакеты не найдены."
#fi

# Обновление mandb (базы данных man страниц)
#print_message "Обновление базы данных man страниц..."
#mandb --quiet || echo -e "\e[1;33mПредупреждение: Не удалось обновить базу данных man страниц\e[0m"

print_message "Done..."
read
