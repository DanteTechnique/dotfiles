#!/usr/bin/env bash

print_message() {
  txtgreen="\e[$(tput setaf 2)"
  txtreset="\e[$(tput sgr0)"
  echo
  echo -e "${txtgreen}$1${txtreset}"
}

ascii() {
  txtblack="\e[$(tput setaf 0)"
  txtbold="\e[$(tput bold)"
  bgrwhite="\e[$(tput setab 7)"
  txtreset="\e[$(tput sgr0)"
  echo -e "${bgrwhite}${txtblack}${txtbold}$1${txtreset}"
}

ascii "___  ________   ________  _________  ________  ___       ___           ________  ___  ___       "
ascii "|\  \|\   ___  \|\   ____\|\___   ___\\   __  \|\  \     |\  \         |\   ____\|\  \|\  \      "
ascii "\ \  \ \  \\ \  \ \  \___|\|___ \  \_\ \  \|\  \ \  \    \ \  \        \ \  \___|\ \  \\\  \       "
ascii " \ \  \ \  \\ \  \ \_____  \   \ \  \ \ \   __  \ \  \    \ \  \        \ \_____  \ \   __  \    "
ascii "  \ \  \ \  \\ \  \|____|\  \   \ \  \ \ \  \ \  \ \  \____\ \  \____  __\|____|\  \ \  \ \  \   "
ascii "   \ \__\ \__\\ \__\____\_\  \   \ \__\ \ \__\ \__\ \_______\ \_______\\__\____\_\  \ \__\ \__\   "
ascii "    \|__|\|__| \|__|\_________\   \|__|  \|__|\|__|\|_______|\|_______\|__|\_________\|__|\|__| "
ascii "                   \|_________|                                           \|_________|          "

#ascii "_________ _        _______ _________ _______  _        _           _______          "
#ascii "\__   __/( (    /|(  ____ \\__   __/(  ___  )( \      ( \         (  ____ \|\     /|"
#ascii "   ) (   |  \  ( || (    \/   ) (   | (   ) || (      | (         | (    \/| )   ( |"
#ascii "   | |   |   \ | || (_____    | |   | (___) || |      | |         | (_____ | (___) |"
#ascii "   | |   | (\ \) |(_____  )   | |   |  ___  || |      | |         (_____  )|  ___  |"
#ascii "   | |   | | \   |      ) |   | |   | (   ) || |      | |               ) || (   ) |"
#ascii "___) (___| )  \  |/\____) |   | |   | )   ( || (____/\| (____/\ _ /\____) || )   ( |"
#ascii "\_______/|/    )_)\_______)   )_(   |/     \|(_______/(_______/(_)\_______)|/     \|"

echo

#backuping previous configuration
print_message "backup your current dotfiles? [y/n]"

while true; do
  read -r -p ">" answer

  answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

  case $answer in
  "y" | "yes")
    echo -e "backuping your previous dotfiles..."
    cp $HOME/.config/ $HOME/.backup_dotfiles/ -r
    break
    ;;
  "n" | "no")
    echo -e "skipping..."
    break
    ;;
  *)
    echo -e "wrong input, please try again"
    ;;
  esac
done

#installing dotfiles
print_message "installing dotfiles..."
cp .config/alacritty $HOME/.config/ -r
cp .config/dunst $HOME/.config/ -r
cp .config/fastfetch $HOME/.config/ -r
cp .config/gtk-3.0 $HOME/.config/ -r
cp .config/gtk-4.0 $HOME/.config/ -r
cp .config/hypr $HOME/.config/ -r
cp .config/Kvantum $HOME/.config/ -r
cp .config/nwg-look $HOME/.config/ -r
cp .config/qt5ct $HOME/.config/ -r
cp .config/qt6ct $HOME/.config/ -r
cp .config/waybar $HOME/.config/ -r
cp .config/wlogout $HOME/.config/ -r
cp .config/wofi $HOME/.config/ -r
cp .config/xsettingsd $HOME/.config -r
cp .icons $HOME/ -r
cp .vimrc $HOME/

# installing packages
print_message "installing packages..."

sudo pacman -Syu

sudo pacman -S hyprland \
  hyprlock \
  hyprpaper \
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
  awesome-terminal-fonts \
  brightnessctl \
  lxappearance \
  qt5ct \
  qt6ct \
  kvantum \
  breeze \
  breeze-gtk \
  nwg-look \
  otf-font-awesome \
  ttf-arimo-nerd \
  noto-fonts

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
#print_message "configuring shell..."

#chsh -s /usr/bin/fish $(whoami)
#curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
#omf install boxfish

read -p "Done..."
