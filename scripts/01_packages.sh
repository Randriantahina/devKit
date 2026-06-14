#!/usr/bin/env bash

log "01 — Installation des paquets apt..."

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

for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" &>/dev/null 2>&1; then
        info "$pkg déjà installé, on passe"
    else
        info "Installation de $pkg..."
        sudo apt-get install -y -qq "$pkg"
    fi
done

log "01 — Paquets installés."
