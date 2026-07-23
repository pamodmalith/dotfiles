# Zsh Configuration

A minimal, modular, framework-free Zsh configuration for my Arch Linux + Hyprland setup.

## Philosophy

This configuration is intentionally built **without a framework** such as Oh My Zsh or Zim.

Instead of relying on a large framework, every feature is configured manually. This keeps the shell lightweight, easier to understand, and easier to maintain.

The goal is to know what every file does.

---

## Structure

```text
zsh
├── .zshrc
└── .config
    └── zsh
        ├── aliases.zsh
        ├── completion.zsh
        ├── exports.zsh
        ├── functions.zsh
        ├── keybindings.zsh
        ├── options.zsh
        └── plugins.zsh
```

### `.zshrc`

Small bootstrap file.

Loads the modular configuration files in the correct order.

### `options.zsh`

Shell behavior.

Examples:

* shell options (`setopt`)
* history behavior
* editor mode
* word movement settings

### `exports.zsh`

Environment variables.

Examples:

* `PATH`
* `EDITOR`
* `BROWSER`
* custom environment variables

### `aliases.zsh`

Command aliases.

### `functions.zsh`

Custom shell functions.

### `completion.zsh`

Zsh completion configuration.

Includes completion styles, cache, and completion behavior.

### `plugins.zsh`

Loads external tools and plugins.

Current plugins:

* Starship
* zoxide
* fzf
* fnm
* zsh-autosuggestions
* zsh-syntax-highlighting
* zsh-history-substring-search

### `keybindings.zsh`

Keyboard shortcuts and widget bindings.

Examples:

* Ctrl + Left / Right
* Delete
* History search
* Custom key mappings

---

## Features

* Framework-free configuration
* Modular file layout
* Fast shell startup
* Starship prompt
* zoxide directory jumping
* fzf integration
* fnm (Fast Node Manager)
* Autosuggestions
* Syntax highlighting
* History substring search
* Custom keybindings
* Shared shell history
* Duplicate-free history

---

## Design Goals

* Minimal
* Readable
* Modular
* Easy to debug
* Easy to extend
* XDG-friendly
* Suitable for version control

---

## Future Improvements

* Full XDG (`ZDOTDIR`) migration
* Additional custom shell functions
* Better completion styles
* Improved Git workflow helpers
* Project-specific aliases
* Performance benchmarking

---

Part of my personal Arch Linux + Hyprland dotfiles.
