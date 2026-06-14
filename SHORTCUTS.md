# Devkit — Raccourcis clavier

## Zellij (multiplexeur de terminal)

> Mode par défaut : **locked** (le clavier va directement au shell)
> Pour utiliser Zellij, active d'abord un mode avec Ctrl+G puis une lettre.

| Raccourci | Action |
|-----------|--------|
| `Ctrl+G` | Passer en mode Normal (depuis locked) |
| `Ctrl+G` (depuis n'importe quel mode) | Retour en mode locked |
| `Ctrl+Q` | Quitter Zellij |

### Mode Pane (gestion des panneaux) — `p` depuis Normal

| Raccourci | Action |
|-----------|--------|
| `p` | Entrer en mode Pane |
| `n` | Nouveau pane |
| `r` | Nouveau pane à droite (split vertical) |
| `d` | Nouveau pane en bas (split horizontal) |
| `h / j / k / l` | Naviguer entre panes (vim-style) |
| `←↓↑→` | Naviguer entre panes |
| `f` | Plein écran pour le pane actif |
| `x` | Fermer le pane actif |
| `w` | Toggle panes flottants |
| `c` | Renommer le pane |
| `Tab` | Changer de pane (cycle) |

### Mode Tab (gestion des onglets) — `t` depuis Normal

| Raccourci | Action |
|-----------|--------|
| `t` | Entrer en mode Tab |
| `n` | Nouvel onglet |
| `x` | Fermer l'onglet |
| `r` | Renommer l'onglet |
| `1-9` | Sauter directement à l'onglet N |
| `h / k` | Onglet précédent |
| `l / j` | Onglet suivant |

### Mode Resize (redimensionner) — `r` depuis Normal

| Raccourci | Action |
|-----------|--------|
| `r` | Entrer en mode Resize |
| `h / j / k / l` | Agrandir dans la direction |
| `H / J / K / L` | Réduire dans la direction |
| `+ / =` | Agrandir |
| `-` | Réduire |

### Mode Scroll — `s` depuis Normal

| Raccourci | Action |
|-----------|--------|
| `s` | Entrer en mode Scroll |
| `j / k` | Défiler bas / haut |
| `d / u` | Demi-page bas / haut |
| `f` | Rechercher dans le scrollback |
| `Ctrl+C` | Retour en bas (fin du scrollback) |

### Mode Session — `o` depuis Normal

| Raccourci | Action |
|-----------|--------|
| `o` | Entrer en mode Session |
| `d` | Détacher la session |
| `w` | Gestionnaire de sessions |

### Raccourcis globaux (toujours disponibles, même en locked)

| Raccourci | Action |
|-----------|--------|
| `Alt+h` ou `Alt+←` | Focus pane/tab à gauche |
| `Alt+l` ou `Alt+→` | Focus pane/tab à droite |
| `Alt+j` ou `Alt+↓` | Focus pane en bas |
| `Alt+k` ou `Alt+↑` | Focus pane en haut |
| `Alt+n` | Nouveau pane |
| `Alt+f` | Toggle panes flottants |
| `Alt+[` | Layout précédent |
| `Alt+]` | Layout suivant |
| `Alt+i` | Déplacer onglet à gauche |
| `Alt+o` | Déplacer onglet à droite |

---

## Shell (Bash amélioré)

| Raccourci | Action |
|-----------|--------|
| `Ctrl+R` | Recherche fuzzy dans l'historique (fzf) |
| `Ctrl+T` | Chercher un fichier, coller dans le prompt (fzf) |
| `Ctrl+A` | Début de ligne |
| `Ctrl+E` | Fin de ligne |
| `Ctrl+W` | Supprimer le mot précédent |
| `Ctrl+U` | Supprimer toute la ligne |

---

## Aliases rapides

| Commande | Action |
|----------|--------|
| `n` ou `n <fichier>` | Ouvrir nvim (NvChad) |
| `lzg` | lazygit |
| `ls` | eza avec icônes |
| `lsa` | eza tout (avec fichiers cachés) |
| `lt` | eza en arbre (niveau 2) |
| `ff` | fzf avec preview bat |
| `bat <fichier>` | cat avec coloration syntaxique |
| `z <partial>` | cd intelligent (zoxide) |
| `..` / `...` / `....` | Remonter 1/2/3 niveaux |
| `g` | git |
| `d` | docker |
| `gcm "msg"` | git commit -m |
| `gcam "msg"` | git commit -a -m |
| `a` | php artisan |
| `maj` | apt update + upgrade |
| `s` | Stripe webhook listener |

---

## Alacritty

| Raccourci | Action |
|-----------|--------|
| `F11` | Plein écran |
| `Ctrl+Shift+C` | Copier (sélection) |
| `Ctrl+Shift+V` | Coller |
