#!/usr/bin/env bash

log "05 — Déploiement des configs (dotfiles)..."

backup_and_link() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    # Backup si c'est un vrai fichier (pas déjà un symlink vers nous)
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        local bak_name
        bak_name="$(basename "$dest").bak"
        cp "$dest" "$DEVKIT_BACKUP_DIR/$bak_name"
        info "Backup de $(basename "$dest") → $DEVKIT_BACKUP_DIR/$bak_name"
        rm "$dest"
    elif [ -L "$dest" ]; then
        rm "$dest"
    fi

    ln -sf "$src" "$dest"
    info "Lien : $dest → $src"
}

# --- Alacritty ---
mkdir -p "$HOME/.config/alacritty"
for f in alacritty.toml shared.toml font.toml font-size.toml theme.toml; do
    backup_and_link "$DEVKIT_DIR/configs/alacritty/$f" "$HOME/.config/alacritty/$f"
done

# --- Zellij ---
mkdir -p "$HOME/.config/zellij"
backup_and_link "$DEVKIT_DIR/configs/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

# --- Bash configs dans ~/.local/share/devkit/ ---
mkdir -p "$HOME/.local/share/devkit/configs/bash"
for f in rc shell aliases functions prompt init; do
    ln -sf "$DEVKIT_DIR/configs/bash/$f" "$HOME/.local/share/devkit/configs/bash/$f"
done
info "Configs bash déployées dans ~/.local/share/devkit/configs/bash/"

# --- ~/.bashrc : injecte le source devkit si pas déjà présent ---
if ! grep -q 'devkit' "$HOME/.bashrc"; then
    cp "$HOME/.bashrc" "$DEVKIT_BACKUP_DIR/bashrc.bak"
    info "Backup de .bashrc → $DEVKIT_BACKUP_DIR/bashrc.bak"

    # Insère au tout début du fichier (avant tout le reste)
    {
        echo 'source ~/.local/share/devkit/configs/bash/rc'
        echo 'export EDITOR="nvim"'
        echo 'export SUDO_EDITOR="$EDITOR"'
        echo ''
        cat "$HOME/.bashrc"
    } > "$HOME/.bashrc.tmp" && mv "$HOME/.bashrc.tmp" "$HOME/.bashrc"

    info ".bashrc mis à jour avec le source devkit"
else
    info ".bashrc contient déjà devkit, pas de modification"
fi

log "05 — Dotfiles déployés."
