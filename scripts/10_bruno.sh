#!/usr/bin/env bash

log "10 — Installation de Bruno (client API)..."

if command -v bruno &>/dev/null; then
    info "Bruno déjà installé"
else
    case "$PKG_MANAGER" in
        apt)
            info "Téléchargement de la dernière version de Bruno (.deb)..."
            BRUNO_VER=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest \
                | grep '"tag_name"' | cut -d'"' -f4 | tr -d 'v')
            if [ -z "$BRUNO_VER" ]; then
                echo "[devkit] ERREUR : impossible de récupérer la version de Bruno"
                exit 1
            fi
            BRUNO_DEB="$(mktemp --suffix=.deb)"
            curl -fsSL \
                "https://github.com/usebruno/bruno/releases/download/v${BRUNO_VER}/bruno_${BRUNO_VER}_amd64_linux.deb" \
                -o "$BRUNO_DEB"
            sudo dpkg -i "$BRUNO_DEB" 2>/dev/null || true
            sudo apt-get install -f -y -qq
            rm -f "$BRUNO_DEB"
            info "Bruno ${BRUNO_VER} installé"
            ;;
        pacman)
            info "Installation de Bruno via AUR..."
            aur_install bruno-bin
            ;;
    esac
fi

log "10 — Bruno prêt."
