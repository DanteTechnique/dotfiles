#!/bin/bash

case $1 in
  --update)
    alacritty -e bash -c "
  echo '=== Pacman ===';
  sudo pacman -Syu;
  echo -e '\n=== AUR ===';
  yay -Syu;
  echo -e '\n=== Flatpak ===';
  flatpak update -y;
  echo -e '\nГотово! Нажмите Enter...';
  read"
esac
