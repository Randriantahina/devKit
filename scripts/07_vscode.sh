#!/usr/bin/env bash

log "07 — Installation de VS Code + configs + extensions..."

# ─── Installation ─────────────────────────────────────────────────────────────
if command -v code &>/dev/null; then
    info "VS Code déjà installé : $(code --version 2>/dev/null | head -1)"
else
    case "$PKG_MANAGER" in
        apt)
            info "Ajout du repo Microsoft pour VS Code..."
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
                | sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
            sudo chmod a+r /etc/apt/keyrings/microsoft.gpg
            echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
                | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
            sudo apt-get update -qq
            sudo apt-get install -y -qq code
            ;;
        pacman)
            info "Installation de VS Code via AUR..."
            aur_install visual-studio-code-bin
            ;;
    esac
    info "VS Code installé : $(code --version 2>/dev/null | head -1)"
fi

# ─── Configs ──────────────────────────────────────────────────────────────────
VSCODE_USER_DIR="$HOME/.config/Code/User"
mkdir -p "$VSCODE_USER_DIR"

for cfg in settings.json keybindings.json; do
    if [ -f "$DEVKIT_DIR/configs/vscode/$cfg" ]; then
        backup_and_link "$DEVKIT_DIR/configs/vscode/$cfg" "$VSCODE_USER_DIR/$cfg"
    fi
done

# ─── Extensions ───────────────────────────────────────────────────────────────
EXTENSIONS_FILE="$DEVKIT_DIR/configs/vscode/extensions.txt"

if [ -f "$EXTENSIONS_FILE" ] && command -v code &>/dev/null; then
    info "Installation des extensions VS Code..."
    INSTALLED=$(code --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]')
    while IFS= read -r ext; do
        [ -z "$ext" ] && continue
        if echo "$INSTALLED" | grep -q "^$(echo "$ext" | tr '[:upper:]' '[:lower:]')$"; then
            info "  ✓ $ext"
        else
            code --install-extension "$ext" --force 2>/dev/null \
                && info "  + $ext" \
                || info "  ✗ $ext (ignoré)"
        fi
    done < "$EXTENSIONS_FILE"
fi

log "07 — VS Code prêt."
