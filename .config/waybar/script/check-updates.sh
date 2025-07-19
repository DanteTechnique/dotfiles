#!/bin/bash

case $1 in
  --update)
    alacritty -e bash -c "
    ~/.config/waybar/script/pacman.sh
  "  
esac
