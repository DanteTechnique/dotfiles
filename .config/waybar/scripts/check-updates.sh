#!/bin/bash

check_update () {
    local pacman_updates=0
    local aur_updates=0
    local flatpak_updates=0
    local tooltip="No available updates"

    if command -v checkupdates &>/dev/null; then
        pacman_updates=$(checkupdates 2>/dev/null | wc -l)
        pacman_updates=$((pacman_updates + 0))
    fi

    if command -v yay &>/dev/null; then
        aur_updates=$(yay -Qu 2>/dev/null | wc -l)
	aur_updates=$((aur_updates + 0))
    fi

    if command -v flatpak &>/dev/null; then
	    flatpak_updates=$(flatpak remote-ls --updates 2>/dev/null | wc -l)
	    flatpak_updates=$((flatpak_updates + 0))
    fi

    local total=$((pacman_updates + aur_updates + flatpak_updates))
    
    if [ $total -gt 0 ]; then
        tooltip="Packages: Pacman: $pacman_updates | AUR: $aur_updates | Flatpak: $flatpak_updates"
        printf '{"text":"%s","tooltip":"%s"}\n' "$total" "$tooltip"
    else
        echo '{"text":"","tooltip":"No available updates"}'
    fi
}

update_system() {
    alacritty --class floating -e bash -c "~/.config/waybar/scripts/pacman.sh"
}

case "$1" in
    --update)
        update_system
        ;;
    *)
        check_update
        ;;
esac

