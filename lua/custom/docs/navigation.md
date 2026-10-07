# 🧭 Navigation

## Motions (stock Vim — worth drilling)

| Keys | Move |
|---|---|
| `h j k l` | left / down / up / right |
| `w b e` / `W B E` | word / WORD forward, back, end |
| `0 ^ $` | line start, first non-blank, line end |
| `f x` / `F x` / `t x` / `T x` + `;` `,` | find char, repeat forward / back |
| `%` | matching bracket |
| `gg G` | first / last line, `42 G` = line 42 |
| `Ctrl-d Ctrl-u` | half-page down / up |
| `zz zt zb` | center / top / bottom current line |
| `*` `#` | next / prev occurrence of word under cursor |
| `gd gD gr gI` | definition / declaration / references / implementation (LSP) |
| `<leader> D` | type definition (LSP) |

## Text objects (compose with `d c y v`)

| Keys | Select |
|---|---|
| `iw aw` | inner / around word |
| `i" a" i' i( ib ip` | inner string, parens, block, paragraph |
| `it at` | inner / around HTML tag |
| `vip vap` | select paragraph (great with multicursor) |

> Example: `ci"` rewrites a string's content. `dap` deletes a paragraph.

## Windows (this config)

| Keys | Action |
|---|---|
| `Ctrl-h j k l` | focus left / down / up / right window |
| `Ctrl-Up / Down` | taller / shorter (`+5` / `-5`) |
| `Ctrl-Left / Right` | narrower / wider |
| `:vs` `:sp` | vertical / horizontal split |
| `Ctrl-w q` | close window |

## Buffers & files (this config)

| Keys | Action |
|---|---|
| `<leader> s f` | find files |
| `<leader> <leader>` | switch buffer |
| `<leader> s .` | recent files |
| `Ctrl-b` | file tree (neo-tree) |
| `Ctrl-o Ctrl-i` | jump back / forward |
| `''` `` `` `` | back to line / exact position before jump |
| `m a` … `' a` | mark `a`, jump back to it |

## Diagnostics & changes (this config)

| Keys | Action |
|---|---|
| `[ d` `] d` | prev / next diagnostic |
| `<leader> e` | diagnostic under cursor |
| `<leader> q` / `<leader> Q` | buffer / workspace diagnostics → quickfix |
| `[ c` `] c` | prev / next git hunk |

## Mini-workflows

- **“Where was I?”** — `Ctrl-o` jumps back through definitions, searches, edits.
- **“That file again”** — `<leader> s .` beats retyping paths.
- **“Error tour”** — `] d` repeatedly, fix, `<leader> e` for details.
