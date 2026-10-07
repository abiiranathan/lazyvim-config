# 📚 Cheatsheet — Start Here

Builtin docs for **this** Neovim config. Everything here matches your real keymaps.

> Leader is `Space`. Mode letters: `n` normal, `i` insert, `v` visual, `x` visual, `t` terminal.

## Topics

| Guide | What it teaches |
|---|---|
| `navigation` | Motions, windows, buffers, jumps, LSP jumps |
| `keybindings` | Every `<leader>` map in this config, by prefix |
| `multicursor` | Multi-cursor editing: add, skip, match, align |
| `macros` | Record, replay, `:normal`, macros vs multicursor |
| `search-replace` | `/`, Telescope pickers, `:s`, `:g`, quickfix workflows |

## How to use this popup

| Key | Action |
|---|---|
| `q` or `Esc` | Close |
| `j` / `k`, `Ctrl-d` / `Ctrl-u` | Scroll |
| `/` | Search inside the doc |
| `:Cheatsheet <topic>` | Jump to a topic (`Tab` completes) |
| `<leader> ?` | Pick a topic from the list |

## 60-second tour

1. `:` — floating command palette (top of screen, Omarchy-style).
2. `<leader> ?` — this guide, rendered markdown in a popup.
3. `<leader> s f` — find files. `<leader> s g` — grep the project.
4. `<leader> m n` — add a cursor on the next match, then just type.
5. `q a` … `q` … `@ a` — record and replay a macro.

## Help inside Neovim

- `<leader> s h` — search all `:help` pages.
- `<leader> s k` — search every keymap (yours + plugins).
- `:h multicursor` — full multicursor plugin manual.
- `:h` + `Ctrl-d` — topic completion for anything else.
