#!/bin/bash

print_message() {
  echo -e "\e[1;32m$1\e[0m"
}

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
  sudo pacman -Syu || handle_error "Can't update packages"

# AUR
  print_message " ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄ "  
  print_message "█       █  █ █  █   ▄  █"  
  print_message "█   ▄   █  █ █  █  █ █ █"  
  print_message "█  █▄█  █  █▄█  █   █▄▄█▄" 
  print_message "█       █       █    ▄▄  █"
  print_message "█   ▄   █       █   █  █ █"
  print_message "█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█"
  yay -Syu || handle_error "Can't update AUR packages"

# Flatpak
  print_message " ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄   ▄ "
  print_message "█       █   █   █      █       █       █      █   █ █ █"
  print_message "█    ▄▄▄█   █   █  ▄   █▄     ▄█    ▄  █  ▄   █   █▄█ █"
  print_message "█   █▄▄▄█   █   █ █▄█  █ █   █ █   █▄█ █ █▄█  █      ▄█"
  print_message "█    ▄▄▄█   █▄▄▄█      █ █   █ █    ▄▄▄█      █     █▄ "
  print_message "█   █   █       █  ▄   █ █   █ █   █   █  ▄   █    ▄  █"
  print_message "█▄▄▄█   █▄▄▄▄▄▄▄█▄█ █▄▄█ █▄▄▄█ █▄▄▄█   █▄█ █▄▄█▄▄▄█ █▄█"
  flatpak update || handle_error "Can't update Flatpak packages"


print_message "Done..."
read
