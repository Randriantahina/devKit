# devkit

Setup dev complet pour Linux — terminal keyboard-first, stack web/mobile, configs versionnées.  
Compatible **Ubuntu/Debian** (apt) et **Arch Linux** (pacman).

---

## Ce que ça installe

### Terminal & shell

| Outil | Rôle |
|---|---|
| [Alacritty](https://alacritty.org) | Terminal GPU-accelerated |
| [Zellij](https://zellij.dev) | Multiplexeur (onglets + panes, mode keyboard-first) |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder — `Ctrl+R`, `Ctrl+T` |
| [eza](https://github.com/eza-community/eza) | `ls` moderne avec icônes |
| [bat](https://github.com/sharkdp/bat) | `cat` avec coloration syntaxique |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` intelligent (`z <dossier>`) |
| [fd](https://github.com/sharkdp/fd) | Recherche de fichiers rapide |

**Thème :** Catppuccin Macchiato (Alacritty) · Tokyo Night (Zellij)  
**Font :** JetBrainsMono Nerd Font Mono

### Éditeur

| Outil | Rôle |
|---|---|
| [Neovim](https://neovim.io) | Éditeur (AppImage stable sur Ubuntu, pacman sur Arch) |
| [NvChad](https://nvchad.com) | Config Neovim — thème onedark, LSP, formatters, keymaps |
| [VS Code](https://code.visualstudio.com) | IDE — settings, keybindings et extensions versionnés |

### Stack dev

| Outil | Version |
|---|---|
| PHP | Dernière stable (PPA ondrej sur Ubuntu, pacman sur Arch) |
| Composer | Dernière stable (script officiel) |
| Laravel CLI | Dernière stable (via Composer global) |
| Node.js | LTS via [nvm](https://github.com/nvm-sh/nvm) |
| npm | Dernière stable |
| pnpm | Dernière stable (script officiel) |
| MySQL | Serveur (mysql-server / mariadb selon distro) |
| PostgreSQL | Serveur |

### Applications

| Outil | Rôle |
|---|---|
| [Google Chrome](https://www.google.com/chrome/) | Navigateur |
| [Bruno](https://www.usebruno.com) | Client API (alternative Postman) |
| [Flutter](https://flutter.dev) | SDK mobile/web (canal stable) |
| Android SDK | cmdline-tools + platform-tools + android-35 |
| Java JDK 21 | Requis par Android SDK |

---

## Prérequis

- Ubuntu 24.04+ ou Arch Linux
- JetBrainsMono Nerd Font installée (ou modifier `configs/alacritty/font.toml`)
- Sur Arch : un helper AUR ([yay](https://github.com/Jguer/yay) ou [paru](https://github.com/Morganamilo/paru)) pour VS Code, Chrome et Bruno

---

## Installation

```bash
git clone https://github.com/Randriantahina/devKit.git ~/devkit
bash ~/devkit/install.sh
exec bash
```

Puis ouvre **Alacritty** — Zellij démarre automatiquement dedans.

> Les configs existantes sont sauvegardées dans `~/.devkit-backups/` avant toute modification.

---

## Réinstaller / mettre à jour

Le script est idempotent — tu peux le relancer sans risque :

```bash
bash ~/devkit/install.sh
```

---

## Structure

```
devkit/
├── install.sh              # Point d'entrée
├── SHORTCUTS.md            # Tous les raccourcis clavier
├── lib/
│   └── detect.sh           # Détection distro (apt / pacman) + helpers
├── configs/
│   ├── alacritty/          # Terminal (Catppuccin Macchiato + JetBrainsMono)
│   ├── zellij/             # Multiplexeur (Tokyo Night, mode locked)
│   ├── bash/               # Shell — aliases, fonctions, PATH, init
│   ├── nvchad/             # Config Neovim complète (plugins, LSP, keymaps)
│   └── vscode/             # settings.json · keybindings.json · extensions.txt
└── scripts/
    ├── 01_packages.sh      # Outils terminal (multi-distro)
    ├── 02_alacritty.sh     # Terminal par défaut
    ├── 03_zellij.sh        # Zellij depuis GitHub releases
    ├── 04_tools.sh         # Symlinks bat/fd (Ubuntu uniquement)
    ├── 05_dotfiles.sh      # Déploiement configs + backup
    ├── 06_dev_stack.sh     # PHP · Composer · Laravel · Node · pnpm · MySQL · PostgreSQL
    ├── 07_vscode.sh        # VS Code + configs + extensions
    ├── 08_chrome.sh        # Google Chrome
    ├── 09_neovim.sh        # Neovim + NvChad + config
    ├── 10_bruno.sh         # Bruno (client API)
    └── 11_flutter.sh       # Flutter + Android SDK + Java
```

---

## Raccourcis essentiels

### Zellij

| Raccourci | Action |
|---|---|
| `Ctrl+G` | Activer le mode Normal (depuis locked) |
| `p` → `n` | Nouveau pane |
| `p` → `r` | Split vertical |
| `p` → `d` | Split horizontal |
| `p` → `h/j/k/l` | Naviguer entre panes |
| `t` → `n` | Nouvel onglet |
| `t` → `1-9` | Sauter à l'onglet N |
| `Alt+h/l` | Focus pane gauche/droite |

### Shell

| Raccourci | Action |
|---|---|
| `Ctrl+R` | Historique fuzzy (fzf) |
| `Ctrl+T` | Chercher un fichier (fzf) |
| `z <dossier>` | cd intelligent (zoxide) |
| `n` | nvim (NvChad) |
| `lzg` | lazygit |
| `a` | php artisan |

Voir `SHORTCUTS.md` pour la liste complète.

---

## Personnalisation

- **Thème Alacritty :** modifier `configs/alacritty/theme.toml`
- **Taille de police :** modifier `configs/alacritty/font-size.toml`
- **Font :** modifier `configs/alacritty/font.toml`
- **Aliases :** ajouter dans `configs/bash/aliases`
- **Extensions VS Code :** mettre à jour `configs/vscode/extensions.txt`
- **Plugins NvChad :** modifier `configs/nvchad/lua/plugins/init.lua`

Après modification des configs bash, recharge avec `exec bash`.
