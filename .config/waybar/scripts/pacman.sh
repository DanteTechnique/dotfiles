#!/usr/bin/env bash

print_message() {
  txtgreen='\e[1;32m'
  txtwhite='\e[0m'
  echo -e "${txtgreen}$1${txtwhite}"
}

handle_error() {
  txtred='\e[1;31m'
  txtwhite='\e[0m'
  echo -e "${txtred}Error: $1${txtwhite}" >&2
}

print_message " ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ ▄▄    ▄ "
print_message "█       █       █       █  █▄█  █       █  █  █ █"
print_message "█    ▄  █   ▄   █       █       █   ▄   █   █▄█ █"
print_message "█   █▄█ █  █▄█  █     ▄▄█       █  █▄█  █       █"
print_message "█    ▄▄▄█       █    █  █       █       █  ▄    █"
print_message "█   █   █   ▄   █    █▄▄█ ██▄██ █   ▄   █ █ █   █"
print_message "█▄▄▄█   █▄▄█ █▄▄█▄▄▄▄▄▄▄█▄█   █▄█▄▄█ █▄▄█▄█  █▄▄█"
sudo pacman -Syu || handle_error "Can't update packages"

print_message " ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄ "
print_message "█       █  █ █  █   ▄  █"
print_message "█   ▄   █  █ █  █  █ █ █"
print_message "█  █▄█  █  █▄█  █   █▄▄█▄"
print_message "█       █       █    ▄▄  █"
print_message "█   ▄   █       █   █  █ █"
print_message "█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄█  █▄█"
yay -Syu || handle_error "Can't update AUR packages"

print_message " ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄▄▄▄▄ ▄▄▄   ▄ "
print_message "█       █   █   █      █       █       █      █   █ █ █"
print_message "█    ▄▄▄█   █   █  ▄   █▄     ▄█    ▄  █  ▄   █   █▄█ █"
print_message "█   █▄▄▄█   █   █ █▄█  █ █   █ █   █▄█ █ █▄█  █      ▄█"
print_message "█    ▄▄▄█   █▄▄▄█      █ █   █ █    ▄▄▄█      █     █▄ "
print_message "█   █   █       █  ▄   █ █   █ █   █   █  ▄   █    ▄  █"
print_message "█▄▄▄█   █▄▄▄▄▄▄▄█▄█ █▄▄█ █▄▄▄█ █▄▄▄█   █▄█ █▄▄█▄▄▄█ █▄█"
flatpak update || handle_error "Can't update Flatpak packages"

print_message "Done..."
sleep 5
