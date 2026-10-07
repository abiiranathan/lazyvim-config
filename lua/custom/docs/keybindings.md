# ⌨️ Keybindings (this config)

Leader is `Space`. Buffer-local LSP maps only exist in code files.

## General

| Keys | Mode | Action |
|---|---|---|
| `Esc` | n | clear search highlight |
| `Ctrl-s` | n i v | save file |
| `Alt-j` / `Alt-k`, `Ctrl-Shift-Down` / `Ctrl-Shift-Up` | n x | move line / selection down / up |
| `<leader> o` | n | open file in system viewer |
| `<leader> f` | all | format buffer |
| `<leader> ?` | n | this cheatsheet |
| `?` … `q`/`Esc` | cheatsheet | close popup |

## Search (Telescope, `<leader> s`)

| Keys | Action |
|---|---|
| `<leader> s f` | files |
| `<leader> s g` | grep project (live) |
| `<leader> s w` | word under cursor |
| `<leader> s /` | grep open files |
| `<leader> /` | fuzzy find in current buffer |
| `<leader> s .` | recent files |
| `<leader> s n` | Neovim config files |
| `<leader> s d` | diagnostics |
| `<leader> s h` | help tags |
| `<leader> s k` | keymaps |
| `<leader> s s` | all pickers |
| `<leader> s r` | resume last picker |
| `<leader> s R` | find & replace across project (grug-far) |
| `<leader> s p` | yank history |
| `<leader> <leader>` | buffers |

## Command palette & terminal

| Keys | Mode | Action |
|---|---|---|
| `:` | n | floating command palette |
| `<leader> :` | n | command history |
| `<leader> f t` | n | floating terminal (project) |
| `<leader> f T` | n | floating terminal (file's folder) |
| `Ctrl-/` | n t | toggle floating terminal |
| `<leader> z` | n | toggle floating terminal (alias) |

## Code (LSP, buffer-local)

| Keys | Action |
|---|---|
| `gd gD gr gI` | definition / declaration / references / implementation |
| `<leader> g d` | definition (same as `gd`) |
| `K` | hover docs |
| `<leader> r n` | rename symbol |
| `<leader> c a`, `<leader> .`, `Ctrl-.` | quick fix menu with diff preview (normal + visual) |
| `<leader> a f` | auto-fix: applies the single fix, menus when several, tells you when none |
| `<leader> s o` / `<leader> s a` | organize imports / source actions |
| `<leader> d s` / `<leader> w s` | document / workspace symbols |
| `<leader> D` | type definition |
| `<leader> t h` | toggle inlay hints |

> 💡 A lightbulb sign marks lines with an available fix. If `Ctrl-.`
> does nothing, your terminal ate it — use `<leader> .` instead.

## Navigation (flash, surround, buffers)

| Keys | Mode | Action |
|---|---|---|
| `s` + label | n x o | flash-jump to any visible text |
| `S` | n x o | flash out via Treesitter node |
| `[ b` / `] b` | n | prev / next buffer (tabs on top) |
| `<leader> b d` | n | delete buffer |
| `<leader> b o` | n | delete other buffers |
| `<leader> b p` | n | pin buffer tab |
| `g z a w )` | n | surround word with parens (surround = `gz` + `a/d/r`) |
| `g z d '` | n | delete surrounding quotes |
| `g z r ) '` | n | replace `)` with `'` |
| `z R` / `z M` | n | open / close all folds |

## Sessions, outline, git UI, tests

| Keys | Action |
|---|---|
| `<leader> q s` | restore session for cwd |
| `<leader> q S` | pick a session |
| `<leader> q d` | stop saving session |
| `<leader> c o` | symbol outline sidebar |
| `<leader> x x` / `<leader> x X` | diagnostics panel (all / buffer) |
| `<leader> c l` | definitions/references panel |
| `<leader> g g` | neogit status |
| `<leader> g d` / `<leader> g D` | diff working tree / file history |
| `<leader> t t` / `<leader> t T` | test nearest / test file |
| `<leader> t a` / `<leader> t s` / `<leader> t o` | test all / summary / output |
| `<leader> u` | undo tree |
| `[ y` / `] y` | cycle yank history after paste |

## Git hunks

| Keys | Action |
|---|---|
| `[ c` `] c` | prev / next hunk |
| `<leader> h s` / `<leader> h r` | stage / reset hunk (works in visual too) |
| `<leader> h p` | preview hunk |
| `<leader> h b` | blame line |
| `<leader> h d` / `<leader> h D` | diff vs index / vs last commit |
| `<leader> h S` / `<leader> h R` / `<leader> h u` | stage buffer / reset buffer / undo stage |
| `<leader> t b` / `<leader> t D` | toggle blame / deleted lines |

## Multicursor (`<leader> m`)

| Keys | Mode | Action |
|---|---|---|
| `Alt-Up` / `Alt-Down` | n x | cursor on line above / below |
| `<leader> m n` / `<leader> m N` | n x | add next / previous match |
| `<leader> m s` / `<leader> m S` | n x | skip next / previous match |
| `<leader> m a` | n x | cursor on ALL matches |
| `<leader> m x` | n x | delete main cursor |
| `<leader> m v` | n | restore cursors |
| `<leader> m c` | n x | clear cursors |
| `Ctrl-q` | n x | toggle cursors on/off |
| `Ctrl-click` / drag | n | cursor by mouse |
| `Left` / `Right` | n x | prev / next cursor (while active) |
| `Esc` | n | enable, or clear all (while active) |

## Completion (insert mode)

| Keys | Action |
|---|---|
| `Ctrl-n` / `Ctrl-p` | next / previous item |
| `Enter` | confirm |
| `Ctrl-Space` | trigger completion |
| `Ctrl-b` / `Ctrl-f` | scroll docs |
| `Ctrl-l` / `Ctrl-h` | snippet jump forward / back |

## Debug

| Keys | Action |
|---|---|
| `F5` | start / continue |
| `F1` `F2` `F3` | step into / over / out |
| `F7` | debugger UI |
| `<leader> b` / `<leader> B` | breakpoint / conditional breakpoint |
