#!/usr/bin/env bash
set -euo pipefail

DEVKIT_DIR="$(cd "$(dirname "$0")" && pwd)"
export DEVKIT_DIR
export DEVKIT_BACKUP_DIR="$HOME/.devkit-backups/$(date +%Y%m%d_%H%M%S)"

log()  { echo "[devkit] $*"; }
info() { echo "[devkit]   → $*"; }
export -f log info

echo ""
echo "  ██████╗ ███████╗██╗   ██╗██╗  ██╗██╗████████╗"
echo "  ██╔══██╗██╔════╝██║   ██║██║ ██╔╝██║╚══██╔══╝"
echo "  ██║  ██║█████╗  ██║   ██║█████╔╝ ██║   ██║   "
echo "  ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔═██╗ ██║   ██║   "
echo "  ██████╔╝███████╗ ╚████╔╝ ██║  ██╗██║   ██║   "
echo "  ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝   ╚═╝   "
echo ""

# Détection de la distribution — exporte $DISTRO et $PKG_MANAGER
# shellcheck disable=SC1091
source "$DEVKIT_DIR/lib/detect.sh"

echo "  Distro détectée : $DISTRO ($PKG_MANAGER)"
echo ""

log "Démarrage de l'installation..."
log "Les backups seront dans : $DEVKIT_BACKUP_DIR"
mkdir -p "$DEVKIT_BACKUP_DIR"
mkdir -p "$HOME/.local/bin"

for script in "$DEVKIT_DIR"/scripts/*.sh; do
    source "$script"
done

log ""
log "====================================================="
log "  Devkit installé avec succès ! ($DISTRO / $PKG_MANAGER)"
log "====================================================="
log ""
log "  Prochaines étapes :"
log "  1. Lance : exec bash"
log "  2. Ouvre Alacritty"
log "  3. Lance 'nvim' pour finaliser NvChad"
log "  4. Consulte les raccourcis : cat ~/devkit/SHORTCUTS.md"
log ""
log "  Stack dispo : php · composer · laravel · node · pnpm · mysql · psql"
log "               nvim (NvChad) · bruno · flutter · android SDK"
log ""
