#!/usr/bin/env bash
# Détection de la distribution Linux et abstraction du gestionnaire de paquets.
# Sourcé par install.sh avant tous les scripts numérotés.

detect_distro() {
    if [ ! -f /etc/os-release ]; then
        echo "[devkit] ERREUR : /etc/os-release introuvable"
        exit 1
    fi

    # shellcheck disable=SC1091
    . /etc/os-release
    local id="${ID:-unknown}"
    local like="${ID_LIKE:-}"

    if [ "$id" = "arch" ] || [[ "$like" == *"arch"* ]] || command -v pacman &>/dev/null; then
        DISTRO="arch"
        PKG_MANAGER="pacman"
    elif [ "$id" = "ubuntu" ] || [ "$id" = "debian" ] || \
         [[ "$like" == *"debian"* ]] || [[ "$like" == *"ubuntu"* ]] || \
         command -v apt-get &>/dev/null; then
        DISTRO="debian"
        PKG_MANAGER="apt"
    else
        echo "[devkit] ERREUR : distribution non supportée : $id"
        echo "[devkit]   Distributions supportées : Ubuntu/Debian, Arch Linux"
        exit 1
    fi

    export DISTRO PKG_MANAGER
}

pkg_install() {
    case "$PKG_MANAGER" in
        pacman) sudo pacman -S --noconfirm --needed "$@" ;;
        apt)    sudo apt-get install -y -qq "$@" ;;
    esac
}

pkg_installed() {
    case "$PKG_MANAGER" in
        pacman) pacman -Q "$1" &>/dev/null ;;
        apt)    dpkg -s "$1" &>/dev/null 2>&1 ;;
    esac
}

# Essaie yay puis paru ; affiche une erreur claire si aucun helper AUR n'est dispo
aur_install() {
    if command -v yay &>/dev/null; then
        yay -S --noconfirm --needed "$@"
    elif command -v paru &>/dev/null; then
        paru -S --noconfirm --needed "$@"
    else
        echo "[devkit] ERREUR : aucun helper AUR trouvé (yay ou paru requis)"
        echo "[devkit]   → https://github.com/Jguer/yay"
        echo "[devkit]   Paquets manquants : $*"
        return 1
    fi
}

export -f pkg_install pkg_installed aur_install

detect_distro
