#!/usr/bin/env bash

log "02 — Configuration d'Alacritty..."

# Enregistre Alacritty comme terminal par défaut
if command -v alacritty &>/dev/null && command -v update-alternatives &>/dev/null; then
    ALACRITTY_PATH=$(command -v alacritty)
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator \
        "$ALACRITTY_PATH" 50 2>/dev/null || true
    info "Alacritty enregistré comme x-terminal-emulator"
fi

log "02 — Alacritty configuré."
