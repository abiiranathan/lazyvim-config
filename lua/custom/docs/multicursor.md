# 🖐️ Multicursor

True multiple cursors (plugin `multicursor.nvim`). Every cursor types together.

## Core loop

1. Add cursors (below).
2. Type / delete / `c` `y` `p` — everything repeats per cursor.
3. `Esc` — done (clears all).

## Adding cursors

| Keys | Mode | Action |
|---|---|---|
| `Alt-Down` / `Alt-Up` | n x | cursor on line below / above |
| `<leader> m n` | n x | select word, add next match (repeat to grow) |
| `<leader> m N` | n x | add previous match |
| `<leader> m s` / `<leader> m S` | n x | skip an unwanted match |
| `<leader> m a` | n x | ALL matches at once |
| `Ctrl-click` / drag | n | place by mouse |
| `<leader> <Up/Down>` | n x | skip line above / below |

> Tip: in visual mode, select any text first — matching uses the selection.

## Managing cursors

| Keys | Action |
|---|---|
| `Ctrl-q` | disable (keep) / re-enable |
| `Left` / `Right` | jump main cursor prev / next (while active) |
| `<leader> m x` | delete the main cursor |
| `<leader> m v` | restore cursors after clearing |
| `<leader> m c` or `Esc` | clear all |

## Recipes

**Rename a variable in one block**

- `*` on the variable, `<leader> m a`, `c`, type new name, `Esc`.

**Skip the odd one out**

- `<leader> m n` … `<leader> m n`, `<leader> m s` skips the match you don't want.

**Edit a column of lines**

- `Alt-Down` × 5, `I`, type, `Esc`. Or visual-block `Ctrl-v` + `I` (stock Vim).

**Number a list `1. 2. 3.`**

- Cursors on each line, visual `y`? No — use `g Ctrl-a`: with cursors on numbers, `g Ctrl-a` increments each one sequentially.

**Align text across cursors**

- See `:h multicursor` search/split/align actions (`splitCursors`, `alignCursors`).

## When NOT to use it

| Situation | Better tool |
|---|---|
| Same edit on 100+ lines / whole file | macros (`:Cheatsheet macros`) or `:%s` |
| Repeating a complex multi-step edit | record a macro, replay with `@@` |
| Rectangular block insert | stock `Ctrl-v`, `I`, type, `Esc` |

Full manual: `:h multicursor`.
