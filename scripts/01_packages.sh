#!/usr/bin/env bash

log "01 — Installation des paquets système..."

case "$PKG_MANAGER" in
    apt)
        sudo apt-get update -qq
        PACKAGES=(
            alacritty
            fzf
            bat
            eza
            zoxide
            fd-find
            xclip
            curl
            git
            unzip
        )
        ;;
    pacman)
        sudo pacman -Sy --noconfirm
        PACKAGES=(
            alacritty
            fzf
            bat
            eza
            zoxide
            fd
            xclip
            curl
            git
            unzip
        )
        ;;
esac

for pkg in "${PACKAGES[@]}"; do
    if pkg_installed "$pkg"; then
        info "$pkg déjà installé, on passe"
    else
        info "Installation de $pkg..."
        pkg_install "$pkg"
    fi
done

log "01 — Paquets installés."
