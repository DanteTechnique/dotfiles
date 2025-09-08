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

copy_with_progress() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ]; then
    echo "Error: '$src' doesn't exist!"
    return 1
  fi

  if [ -d "$src" ]; then
    local dir_name=$(basename "$src")
    local final_dest="$dest/$dir_name"

    echo "Copying directory: $src -> $final_dest"

    mkdir -p "$dest"

    local total_files=$(find "$src" -type f | wc -l)
    local copied_files=0

    find "$src" -type d -exec mkdir -p "$final_dest/{}" \; 2>/dev/null

    while IFS= read -r -d '' file; do
      if [ -f "$file" ]; then
        local relative_path="${file#$src/}"
        local dest_file="$final_dest/$relative_path"

        cp "$file" "$dest_file"

        copied_files=$((copied_files + 1))
        local percent=$((copied_files * 100 / total_files))

        local bar=""
        local filled=$((percent / 2))
        local empty=$((50 - filled))

        for ((i = 0; i < filled; i++)); do bar+="█"; done
        for ((i = 0; i < empty; i++)); do bar+="░"; done

        printf "\r[%s] %3d%% File: %s" "$bar" "$percent" "$relative_path"
      fi
    done < <(find "$src" -type f -print0)

    echo -e "\nDone! Copied files: $copied_files"

  elif [ -f "$src" ]; then
    echo "Copying file: $src -> $dest"
  fi
}

#starting script

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
  read -r -p "> " answer

  answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')

  case $answer in
  "y" | "yes")
    echo -e "backuping your previous dotfiles..."
    copy_with_progress "$HOME/.config/" "$HOME/.backup-dotfiles/"
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

sleep 5

#installing dotfiles
print_message "installing dotfiles..."

sleep 5

copy_with_progress ".config/alacritty" "$HOME/.config/"
copy_with_progress ".config/dunst" "$HOME/.config/"
copy_with_progress ".config/fastfetch" "$HOME/.config/"
copy_with_progress ".config/gtk-3.0" "$HOME/.config/"
copy_with_progress ".config/gtk-4.0" "$HOME/.config/"
copy_with_progress ".config/hypr" "$HOME/.config/"
copy_with_progress ".config/Kvantum" "$HOME/.config/"
copy_with_progress ".config/nwg-look" "$HOME/.config/"
copy_with_progress ".config/qt5ct" "$HOME/.config/"
copy_with_progress ".config/qt6ct" "$HOME/.config/"
copy_with_progress ".config/waybar" "$HOME/.config/"
copy_with_progress ".config/wlogout" "$HOME/.config/"
copy_with_progress ".config/wofi" "$HOME/.config/"
copy_with_progress ".config/xsettingsd" "$HOME/.config"
copy_with_progress ".icons" "$HOME/"
copy_with_progress ".vimrc" "$HOME/"

sleep 5

# installing packages
print_message "installing packages..."

sudo pacman -Syu

sudo pacman -S hyprland \
  hyprlock \
  hyprpaper \
  hypridle \
  hyprsunset \
  waybar \
  pacman-contrib \
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

sleep 5

# installing AUR helper
print_message "installing yay..."

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si

sleep 5

# installing AUR packages
print_message "installing AUR packages..."

yay -S pacseek \
  wlogout \
  waterfox-bin

sleep 5

# changing shell and installing oh-my-fish
print_message "configuring shell..."
chsh -s /usr/bin/fish $(whoami)

cd /tmp
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
bin/install --offline

#rebooting
while true; do
  read -r -p "to work properly reboot your pc, do it now? [y/n] " answer2

  answer2=$(echo "$answer2" | tr '[:upper:]' '[:lower:]')

  case $answer2 in
  "y" | "yes")
    echo -e "rebooting..."
    sudo systemctl reboot
    break
    ;;
  "n" | "no")
    echo
    break
    ;;
  *)
    echo -e "wrong input, please try again"
    ;;
  esac
done

read -p "$(tput setaf 2)installation done..."
