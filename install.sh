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
echo "  Terminal setup inspiré d'Omakub — pour Ubuntu dev"
echo ""

log "Démarrage de l'installation..."
log "Les backups seront dans : $DEVKIT_BACKUP_DIR"
mkdir -p "$DEVKIT_BACKUP_DIR"
mkdir -p "$HOME/.local/bin"

for script in "$DEVKIT_DIR"/scripts/*.sh; do
    source "$script"
done
