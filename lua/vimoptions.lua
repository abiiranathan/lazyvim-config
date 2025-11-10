-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.filetype.add { extension = { templ = 'templ' } }

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.laststatus = 2

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300
vim.o.winborder = 'rounded'

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Open current file in system default viewer (usually xdg-open)
vim.keymap.set('n', '<leader>o', ':!xdg-open %<CR>')

-- Diagnostic keymaps
-- Go to previous diagnostic message
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto({ prev = true })
end, { desc = 'Go to previous [D]iagnostic message' })

-- Go to next diagnostic message
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto({ next = true })
end, { desc = 'Go to next [D]iagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinds to make buffer navigation easier.
-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move the current line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move the current line up' })

-- Move selected line / block of text in visual mode
vim.keymap.set('x', '<A-j>', ":move '>+1<CR>gv-gv", { desc = 'Move the selected lines down' })
vim.keymap.set('x', '<A-k>', ":move '<-2<CR>gv-gv", { desc = 'Move the selected lines up' })

--Key map to resize the window
vim.keymap.set('n', '<C-Up>', ':resize +5<CR>', { desc = 'Resize the window height by 5' })
vim.keymap.set('n', '<C-Down>', ':resize -5<CR>', { desc = 'Resize the window height by -5' })
vim.keymap.set('n', '<C-Left>', ':vertical resize -5<CR>', { desc = 'Resize the window width by -5' })
vim.keymap.set('n', '<C-Right>', ':vertical resize +5<CR>', { desc = 'Resize the window width by 5' })

-- Save file with Ctrl+S in Normal, Insert, and Visual modes
vim.keymap.set('n', '<C-s>', '<cmd>write<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>write<CR>a', { desc = 'Save file', silent = true })
vim.keymap.set('v', '<C-s>', '<Esc><cmd>write<CR>gv', { desc = 'Save file', silent = true })