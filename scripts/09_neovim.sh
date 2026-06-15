#!/usr/bin/env bash

log "09 — Installation de Neovim + NvChad..."

# ─── Neovim ───────────────────────────────────────────────────────────────────
if command -v nvim &>/dev/null; then
    info "Neovim déjà installé : $(nvim --version 2>/dev/null | head -1)"
else
    case "$PKG_MANAGER" in
        apt)
            # La version apt est souvent trop ancienne pour NvChad — on prend l'AppImage stable
            info "Téléchargement de Neovim AppImage (version stable depuis GitHub)..."
            NVIM_VER=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
                | grep '"tag_name"' | cut -d'"' -f4)
            if [ -z "$NVIM_VER" ]; then
                echo "[devkit] ERREUR : impossible de récupérer la version de Neovim"
                exit 1
            fi
            curl -fsSL \
                "https://github.com/neovim/neovim/releases/download/${NVIM_VER}/nvim-linux-x86_64.appimage" \
                -o "$HOME/.local/bin/nvim"
            chmod +x "$HOME/.local/bin/nvim"
            info "Neovim ${NVIM_VER} installé dans ~/.local/bin/nvim"
            ;;
        pacman)
            info "Installation de Neovim via pacman..."
            pkg_install neovim
            ;;
    esac
fi

# ─── NvChad ───────────────────────────────────────────────────────────────────
if [ -d "$HOME/.config/nvim/.git" ]; then
    info "NvChad déjà présent dans ~/.config/nvim/"
else
    if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        info "~/.config/nvim/ existe déjà — backup..."
        mv "$HOME/.config/nvim" "$DEVKIT_BACKUP_DIR/nvim.bak"
    fi
    info "Clonage du starter NvChad..."
    git clone https://github.com/NvChad/starter "$HOME/.config/nvim" --depth=1 --quiet
    info "NvChad cloné"
fi

# ─── Config NvChad personnalisée ──────────────────────────────────────────────
# On écrase les fichiers du starter avec la config versionnée dans le devkit
if [ -d "$DEVKIT_DIR/configs/nvchad" ]; then
    info "Déploiement de la config NvChad (thème onedark, LSP, formatters, keymaps)..."
    cp -r "$DEVKIT_DIR/configs/nvchad/." "$HOME/.config/nvim/"
    info "Config NvChad déployée"
fi

log "09 — Neovim + NvChad prêts. Lance 'nvim' pour installer les plugins."
