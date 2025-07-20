#!/bin/bash

#!/bin/bash

check_update () {
    # Инициализация переменных
    local pacman_updates=0
    local aur_updates=0
    local tooltip="Нет обновлений"

    # Проверка обновлений pacman
    if command -v checkupdates &>/dev/null; then
        pacman_updates=$(checkupdates 2>/dev/null | wc -l)
        pacman_updates=$((pacman_updates + 0))
    fi

    # Проверка обновлений AUR (только yay)
    if command -v yay &>/dev/null; then
        aur_updates=$(yay -Qu 2>/dev/null | wc -l)
        aur_updates=$((aur_updates + 0))
    fi

    # Формирование данных
    local total=$((pacman_updates + aur_updates))
    
    if [ $total -gt 0 ]; then
        tooltip="Обновления: Pacman: $pacman_updates | AUR: $aur_updates"
        printf '{"text":"%s","tooltip":"%s"}\n' "$total" "$tooltip"
    else
        echo '{"text":"","tooltip":"No available updates"}'
    fi
}

# Функция обновления системы
update_system() {
    alacritty -e bash -c "~/.config/waybar/script/pacman.sh"
}

# Обработка аргументов
case "$1" in
    --update)
        update_system
        ;;
    *)
        check_update
        ;;
esac

#case $1 in
#  --update)
#    alacritty -e bash -c "
#    ~/.config/waybar/script/pacman.sh
#  "  
#esac
