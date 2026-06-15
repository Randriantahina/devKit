#!/usr/bin/env bash

log "08 — Installation de Google Chrome..."

if command -v google-chrome &>/dev/null || command -v google-chrome-stable &>/dev/null; then
    info "Google Chrome déjà installé"
else
    case "$PKG_MANAGER" in
        apt)
            info "Téléchargement du .deb Google Chrome stable..."
            CHROME_DEB="$(mktemp --suffix=.deb)"
            curl -fsSL "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
                -o "$CHROME_DEB"
            sudo dpkg -i "$CHROME_DEB" 2>/dev/null || true
            sudo apt-get install -f -y -qq
            rm -f "$CHROME_DEB"
            info "Google Chrome installé"
            ;;
        pacman)
            info "Installation de Google Chrome via AUR..."
            aur_install google-chrome
            ;;
    esac
fi

log "08 — Chrome prêt."
