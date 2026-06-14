#!/usr/bin/env bash

log "03 — Installation de Zellij..."

if command -v zellij &>/dev/null; then
    info "Zellij déjà installé : $(zellij --version)"
else
    info "Téléchargement de Zellij depuis GitHub..."
    ZELLIJ_VER=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest \
        | grep '"tag_name"' | cut -d'"' -f4)

    if [ -z "$ZELLIJ_VER" ]; then
        echo "[devkit] ERREUR : impossible de récupérer la version de Zellij"
        exit 1
    fi

    info "Version : $ZELLIJ_VER"
    curl -sL "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VER}/zellij-x86_64-unknown-linux-musl.tar.gz" \
        | tar -xz -C "$HOME/.local/bin/"

    chmod +x "$HOME/.local/bin/zellij"
    info "Zellij installé dans ~/.local/bin/"
fi

log "03 — Zellij prêt."
