# 🔍 Search & Replace

## In the current file

| Keys | Action |
|---|---|
| `/foo` `?foo` | search forward / backward (`Enter`, then `n` `N`) |
| `*` `#` | next / prev word under cursor |
| `<leader> /` | fuzzy find in buffer |
| `Esc` | clear highlight |
| `:s/old/new/` | current line (first match) |
| `:s/old/new/g` | current line (all) |
| `:%s/old/new/gc` | whole file, confirm each (`c`) |
| `:'<,'>s/old/new/g` | visual selection only |

> Live preview is on (`inccommand`): the buffer updates as you type `:s`.

## Across the project (Telescope)

| Keys | Action |
|---|---|
| `<leader> s g` | live grep |
| `<leader> s w` | grep word under cursor |
| `<leader> s /` | grep open files only |
| `<leader> s f` | find files |

**Replace across files:** `<leader> s g`, `<Ctrl-q>` sends results to the quickfix list, then:

```vim
:cdo s/old/new/g | update
```

(`:cdo` runs on every quickfix entry, `update` saves changed buffers.)

## Power tools

| Command | Action |
|---|---|
| `:g/TODO/d` | delete every TODO line |
| `:g/^$/d` | delete blank lines |
| `:v/error/d` | keep ONLY error lines |
| `:g/foo/normal @a` | run macro `a` on matching lines |
| `:%s/(\w+)/[\1]/g` | capture groups (`\1`, `\2`) |
| `:%s/old/new/gi` | case-insensitive |

## Quickfix & location lists (this config)

| Keys | Action |
|---|---|
| `<leader> q o` / `c` | open / close quickfix |
| `<leader> q n` / `p` | next / prev entry |
| `<leader> q f` / `l` | first / last entry |
| `<leader> l o` `n` `p` `c` | same for location list |
| `<leader> q` / `<leader> Q` | diagnostics → lists |

> Workflow: diagnostics to quickfix (`<leader> q`), walk with `<leader> q n`, fix, repeat.
