#!/usr/bin/env bash

print_message() {
  txtgreen='\e[0;32m'
  txtreset='\e[0m'
  echo
  echo -e "${txtgreen}$1${txtreset}"
}

# installing packages

print_message "installing packages..."

sudo pacman -Syu

sudo pacman -S hyprland \
  hyprlock \
  hypridle \
  hyprsunset \
  waybar \
  wl-clipboard \
  nemo \
  wofi \
  alacritty \
  fish \
  git \
  dunst \
  grim \
  slurp \
  network-manager-applet \
  blueman \
  tmux \
  pavucontrol \
  awesome-terminal-fonts

# installing AUR helper

print_message "installing yay..."

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si

# installing AUR packages

print_message "installing AUR packages..."

yay -S pacseek \
  wlogout \
  waterfox-bin

# changing shell and installing oh-my-fish

print_message "configuring shell..."

chsh -s /usr/bin/fish $(whoami)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install boxfish

read
