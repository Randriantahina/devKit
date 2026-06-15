#!/usr/bin/env bash

log "06 — Installation de la stack dev (PHP, Composer, Laravel, Node, pnpm, MySQL, PostgreSQL)..."

# ─── PHP ──────────────────────────────────────────────────────────────────────
log "  PHP (dernière version stable)..."

if command -v php &>/dev/null; then
    info "PHP déjà installé : $(php -r 'echo PHP_VERSION;' 2>/dev/null)"
else
    case "$PKG_MANAGER" in
        apt)
            info "Ajout du PPA ondrej/php pour la dernière version stable..."
            sudo apt-get install -y -qq software-properties-common
            sudo add-apt-repository -y ppa:ondrej/php
            sudo apt-get update -qq
            sudo apt-get install -y -qq \
                php php-cli php-mbstring php-xml php-curl \
                php-zip php-bcmath php-mysql php-pgsql php-intl php-gd
            ;;
        pacman)
            info "Installation de PHP via pacman..."
            pkg_install php php-gd php-intl
            ;;
    esac
    info "PHP installé : $(php -r 'echo PHP_VERSION;' 2>/dev/null)"
fi

# ─── Composer ─────────────────────────────────────────────────────────────────
log "  Composer (dernière version stable)..."

if command -v composer &>/dev/null; then
    info "Composer déjà installé : $(composer --version --no-ansi 2>/dev/null | head -1)"
else
    info "Téléchargement de Composer depuis getcomposer.org..."
    COMPOSER_TMP=$(mktemp)
    curl -sS https://getcomposer.org/installer -o "$COMPOSER_TMP"
    sudo php "$COMPOSER_TMP" --install-dir=/usr/local/bin --filename=composer --quiet
    rm -f "$COMPOSER_TMP"
    info "Composer installé : $(composer --version --no-ansi 2>/dev/null | head -1)"
fi

# ─── Laravel installer ────────────────────────────────────────────────────────
log "  Laravel installer (dernière version)..."

LARAVEL_BIN="$HOME/.composer/vendor/bin/laravel"
if [ -f "$LARAVEL_BIN" ] || command -v laravel &>/dev/null; then
    info "Laravel installer déjà présent"
else
    info "Installation du Laravel installer via Composer global..."
    composer global require laravel/installer --quiet
    info "Laravel installer prêt dans ~/.composer/vendor/bin/"
fi

# ─── Node.js + npm via nvm ────────────────────────────────────────────────────
log "  Node.js / npm (LTS, via nvm)..."

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
    info "Installation de nvm..."
    NVM_VER=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest \
        | grep '"tag_name"' | cut -d'"' -f4)
    if [ -z "$NVM_VER" ]; then
        echo "[devkit] ERREUR : impossible de récupérer la version de nvm"
        exit 1
    fi
    curl -so- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VER}/install.sh" | bash
    info "nvm ${NVM_VER} installé"
fi

# Charge nvm dans ce shell pour les commandes suivantes
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if command -v node &>/dev/null; then
    info "Node.js déjà installé : $(node -v)"
else
    info "Installation de la dernière LTS Node.js..."
    nvm install --lts
    nvm use --lts
    nvm alias default "lts/*"
    info "Node.js installé : $(node -v)"
fi

info "Mise à jour de npm vers la dernière version..."
npm install -g npm@latest --quiet
info "npm : $(npm -v)"

# ─── pnpm ─────────────────────────────────────────────────────────────────────
log "  pnpm (dernière version)..."

if command -v pnpm &>/dev/null; then
    info "pnpm déjà installé : $(pnpm -v)"
else
    info "Installation de pnpm via son script officiel..."
    curl -fsSL https://get.pnpm.io/install.sh | env SHELL="$(which bash)" bash -
    info "pnpm installé"
fi

# ─── MySQL ────────────────────────────────────────────────────────────────────
log "  MySQL / MariaDB..."

case "$PKG_MANAGER" in
    apt)
        if pkg_installed mysql-server; then
            info "MySQL Server déjà installé"
        else
            info "Installation de MySQL Server..."
            sudo apt-get install -y -qq mysql-server
            sudo systemctl enable mysql
            sudo systemctl start mysql
            info "MySQL démarré et activé au boot"
        fi
        ;;
    pacman)
        if pkg_installed mariadb; then
            info "MariaDB déjà installé"
        else
            info "Installation de MariaDB..."
            pkg_install mariadb
            sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
            sudo systemctl enable mariadb
            sudo systemctl start mariadb
            info "MariaDB démarré et activé au boot"
        fi
        ;;
esac

# ─── PostgreSQL ───────────────────────────────────────────────────────────────
log "  PostgreSQL..."

case "$PKG_MANAGER" in
    apt)
        if pkg_installed postgresql; then
            info "PostgreSQL déjà installé"
        else
            info "Installation de PostgreSQL..."
            sudo apt-get install -y -qq postgresql postgresql-contrib
            sudo systemctl enable postgresql
            sudo systemctl start postgresql
            info "PostgreSQL démarré et activé au boot"
        fi
        ;;
    pacman)
        if pkg_installed postgresql; then
            info "PostgreSQL déjà installé"
        else
            info "Installation de PostgreSQL..."
            pkg_install postgresql
            sudo -u postgres initdb -D /var/lib/postgres/data
            sudo systemctl enable postgresql
            sudo systemctl start postgresql
            info "PostgreSQL démarré et activé au boot"
        fi
        ;;
esac

log "06 — Stack dev installée."
