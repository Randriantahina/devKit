#!/usr/bin/env bash

log "11 — Installation de Flutter + Android SDK..."

FLUTTER_DIR="$HOME/flutter/flutter"
ANDROID_HOME="$HOME/Android/Sdk"

# ─── Dépendances système ──────────────────────────────────────────────────────
log "  Dépendances Flutter..."

case "$PKG_MANAGER" in
    apt)
        FLUTTER_DEPS=(
            curl git unzip xz-utils zip
            libglu1-mesa clang cmake ninja-build pkg-config
            libgtk-3-dev liblzma-dev
        )
        for dep in "${FLUTTER_DEPS[@]}"; do
            pkg_installed "$dep" || pkg_install "$dep"
        done
        ;;
    pacman)
        FLUTTER_DEPS=(
            curl git unzip zip xz
            glu clang cmake ninja pkgconf
            gtk3
        )
        for dep in "${FLUTTER_DEPS[@]}"; do
            pkg_installed "$dep" || pkg_install "$dep"
        done
        ;;
esac

# ─── Java (requis par Android SDK) ───────────────────────────────────────────
log "  Java JDK..."

if command -v java &>/dev/null; then
    info "Java déjà installé : $(java -version 2>&1 | head -1)"
else
    case "$PKG_MANAGER" in
        apt)    pkg_install openjdk-21-jdk ;;
        pacman) pkg_install jdk21-openjdk ;;
    esac
    info "Java installé : $(java -version 2>&1 | head -1)"
fi

# ─── Flutter SDK ──────────────────────────────────────────────────────────────
log "  Flutter SDK (stable)..."

if [ -d "$FLUTTER_DIR/.git" ]; then
    info "Flutter déjà présent : $(PATH="$FLUTTER_DIR/bin:$PATH" flutter --version 2>/dev/null | head -1)"
else
    mkdir -p "$HOME/flutter"
    info "Clonage du SDK Flutter (canal stable)..."
    git clone https://github.com/flutter/flutter.git \
        -b stable --depth 1 --quiet "$FLUTTER_DIR"
    info "Flutter cloné dans $FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

info "Précache des binaires Flutter..."
flutter precache --quiet 2>/dev/null || true

# ─── Android cmdline-tools ────────────────────────────────────────────────────
log "  Android SDK (cmdline-tools)..."

CMDLINE_TOOLS_DIR="$ANDROID_HOME/cmdline-tools/latest"

if [ -f "$CMDLINE_TOOLS_DIR/bin/sdkmanager" ]; then
    info "Android cmdline-tools déjà présents"
else
    info "Téléchargement des Android cmdline-tools..."
    mkdir -p "$ANDROID_HOME/cmdline-tools"

    # Récupère la dernière version depuis le repo Google
    CMDLINE_VER=$(curl -s "https://dl.google.com/android/repository/repository2-3.xml" \
        2>/dev/null | grep -oP 'commandlinetools-linux-\K[0-9]+' | sort -n | tail -1)

    if [ -z "$CMDLINE_VER" ]; then
        # Fallback : version connue stable
        CMDLINE_VER="11076708"
    fi

    CMDLINE_ZIP="$(mktemp --suffix=.zip)"
    curl -fsSL \
        "https://dl.google.com/android/repository/commandlinetools-linux-${CMDLINE_VER}_latest.zip" \
        -o "$CMDLINE_ZIP"

    CMDLINE_TMP="$(mktemp -d)"
    unzip -q "$CMDLINE_ZIP" -d "$CMDLINE_TMP"
    mv "$CMDLINE_TMP/cmdline-tools" "$CMDLINE_TOOLS_DIR"
    rm -rf "$CMDLINE_ZIP" "$CMDLINE_TMP"
    info "Android cmdline-tools installés dans $CMDLINE_TOOLS_DIR"
fi

export PATH="$CMDLINE_TOOLS_DIR/bin:$ANDROID_HOME/platform-tools:$PATH"
export ANDROID_HOME ANDROID_SDK_ROOT="$ANDROID_HOME"

# ─── Android SDK packages ─────────────────────────────────────────────────────
log "  Android SDK packages (platform-tools, build-tools, android-35)..."

if [ -d "$ANDROID_HOME/platform-tools" ]; then
    info "Android platform-tools déjà installés"
else
    info "Installation des packages Android SDK..."
    yes | sdkmanager --sdk_root="$ANDROID_HOME" \
        "platform-tools" \
        "build-tools;35.0.0" \
        "platforms;android-35" \
        2>/dev/null
    info "Android SDK packages installés"
fi

# ─── Licences Android ─────────────────────────────────────────────────────────
info "Acceptation des licences Android..."
yes | flutter doctor --android-licenses 2>/dev/null || true

log "11 — Flutter + Android SDK prêts."
log "     Lance 'flutter doctor' pour vérifier l'état complet."
