#!/usr/bin/env bash

log "04 — Création des symlinks pour les outils..."

mkdir -p "$HOME/.local/bin"

# bat : Ubuntu installe le binaire sous le nom 'batcat'
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
    info "Symlink bat → batcat créé"
fi

# fd : Ubuntu installe le binaire sous le nom 'fdfind'
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    info "Symlink fd → fdfind créé"
fi

# Vérifie que tous les outils critiques sont présents
REQUIRED=(alacritty zellij fzf bat eza zoxide)
MISSING=()
for tool in "${REQUIRED[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        MISSING+=("$tool")
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "[devkit] ERREUR : outils manquants après installation : ${MISSING[*]}"
    exit 1
fi

log "04 — Tous les outils sont prêts."
