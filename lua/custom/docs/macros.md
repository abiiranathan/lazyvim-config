# 🎬 Macros

Record keystrokes once, replay anywhere. Best for multi-step edits multicursor can't do.

## Basics

| Keys | Action |
|---|---|
| `q a` | start recording into register `a` |
| `q` | stop recording |
| `@ a` | replay register `a` |
| `@@` | replay last macro |
| `10 @ a` | replay 10 times |
| `" a p` | paste register `a` (macros are text — editable!) |

## The reliable pattern

1. `0` or `^` — start at a known column first.
2. `q a` … do the edit … `j` … `q` — **end on the next line**.
3. `10 @ a` — replays down the block. Failures stop the run (usually a good sign you're done).

## Examples

**Quote every line**

- `q a`, `I "`, `Esc`, `A "`, `Esc`, `j`, `q` — then `@@` / `10 @ a`.

**Build calls from a word list**

- `q a`, `I print(`, `Esc`, `A )`, `Esc`, `j`, `q`.

**Run an Ex command per line**

- Visual-select lines, then `:'<,'>normal @a` replays macro `a` on each line.

## Registers & duration

- Registers `a–z` persist until overwritten; `"ap` shows the macro as text — yank, edit, replay.
- Uppercase appends: `q A` **appends** to register `a` instead of replacing it.
- `:reg a` inspects without pasting.

## Macros vs the alternatives

| Situation | Tool |
|---|---|
| Same keystrokes on consecutive lines | macro ending with `j` |
| Same word scattered around | `<leader> m n` multicursor |
| Whole-file pattern | `:%s/old/new/g` |
| Per-line Ex command | `:'<,'>normal …` |
| Repeat last change once | `.` (dot) — fastest for single edits |

> Rule of thumb: under ~5 targets use `.` or multicursor; a column of similar lines → macro; whole file → `:s` / `:g`.
