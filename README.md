# devkit

Setup terminal Ubuntu inspiré d'[Omakub](https://github.com/basecamp/omakub), orienté clavier (sans souris), compatible avec NvChad.

## Ce que ça installe

| Outil | Rôle |
|---|---|
| [Alacritty](https://alacritty.org) | Terminal GPU-accelerated |
| [Zellij](https://zellij.dev) | Multiplexeur (onglets + panes) |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder — `Ctrl+R`, `Ctrl+T` |
| [eza](https://github.com/eza-community/eza) | `ls` moderne avec icônes |
| [bat](https://github.com/sharkdp/bat) | `cat` avec coloration syntaxique |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` intelligent (`z <dossier>`) |
| [fd](https://github.com/sharkdp/fd) | Recherche de fichiers rapide |
| [lazygit](https://github.com/jesseduffield/lazygit) | TUI git (si déjà installé) |

**Thème :** Catppuccin Macchiato  
**Font :** JetBrainsMono Nerd Font Mono (doit être installée)  
**Shell :** Bash amélioré avec aliases Omakub

---

## Prérequis

- Ubuntu 24.04 / 25.04 / 26.04
- JetBrainsMono Nerd Font installée (ou modifier `configs/alacritty/font.toml`)
- NvChad non requis mais les aliases `n` et `nvim` le ciblent

---

## Installation

```bash
git clone https://github.com/TON_USERNAME/devkit.git ~/devkit
bash ~/devkit/install.sh
exec bash
```

Puis ouvre **Alacritty** — Zellij démarre automatiquement dedans.

> Les configs existantes sont sauvegardées dans `~/.devkit-backups/` avant toute modification.  
> NvChad, VS Code et Zed ne sont **jamais touchés**.

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
├── configs/
│   ├── alacritty/          # Terminal (Catppuccin Macchiato + JetBrainsMono)
│   │   ├── alacritty.toml
│   │   ├── shared.toml     # Lance Zellij au démarrage
│   │   ├── font.toml
│   │   ├── font-size.toml
│   │   └── theme.toml
│   ├── zellij/
│   │   └── config.kdl      # Copie exacte Omakub (hjkl, mode locked)
│   └── bash/
│       ├── rc              # Point d'entrée bash
│       ├── shell           # Historique, PATH
│       ├── aliases         # Omakub + aliases perso
│       ├── functions       # compress, web2app, etc.
│       ├── prompt          # Prompt minimaliste
│       └── init            # zoxide + fzf init
└── scripts/
    ├── 01_packages.sh      # apt installs
    ├── 02_alacritty.sh     # terminal par défaut
    ├── 03_zellij.sh        # install depuis GitHub releases
    ├── 04_tools.sh         # symlinks bat/fd
    └── 05_dotfiles.sh      # déploiement configs + backup
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
| `Alt+h/l` | Focus pane gauche/droite (sans mode) |

### Shell

| Raccourci | Action |
|---|---|
| `Ctrl+R` | Historique fuzzy (fzf) |
| `Ctrl+T` | Chercher un fichier (fzf) |
| `z <dossier>` | cd intelligent (zoxide) |
| `n` | nvim (NvChad) |
| `lzg` | lazygit |

Voir `SHORTCUTS.md` pour la liste complète.

---

## Personnalisation

- **Thème Alacritty :** modifier `configs/alacritty/theme.toml` (d'autres thèmes dans le repo Omakub)
- **Taille de police :** modifier `configs/alacritty/font-size.toml`
- **Aliases :** ajouter dans `configs/bash/aliases`
- **Font :** modifier `configs/alacritty/font.toml`

Après modification, recharge avec `exec bash` ou relance Alacritty.
