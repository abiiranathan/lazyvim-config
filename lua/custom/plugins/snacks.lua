-- Floating terminal + picker (Omarchy / LazyVim style via snacks.nvim).
-- Replaces toggleterm.nvim. `:` itself becomes a floating cmdline via noice.nvim.
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      picker = { enabled = true },
      dashboard = { enabled = true },
      scroll = { enabled = true },
      terminal = {
        win = {
          style = 'float',
          border = 'rounded',
        },
      },
    },
    keys = {
      -- Command history = the VSCode-style command palette (LazyVim parity)
      {
        '<leader>:',
        function()
          require('snacks').picker.command_history()
        end,
        desc = 'Command History',
      },
      -- Floating terminal in current working directory
      {
        '<leader>ft',
        function()
          require('snacks').terminal()
        end,
        desc = '[F]loating [T]erminal (cwd)',
      },
      {
        '<leader>fT',
        function()
          require('snacks').terminal(nil, { cwd = vim.fn.expand '%:p:h' })
        end,
        desc = 'Floating Terminal (file dir)',
      },
      -- Toggle like Omarchy / LazyVim (<C-/>). <C-_> is the same key for most terminals.
      {
        '<c-/>',
        function()
          require('snacks').terminal()
        end,
        desc = 'Toggle Floating Terminal',
        mode = { 'n', 't' },
      },
      {
        '<c-_>',
        function()
          require('snacks').terminal()
        end,
        desc = 'which_key_ignore',
        mode = { 'n', 't' },
      },
      -- Backward compat with previous toggleterm mapping
      {
        '<leader>z',
        function()
          require('snacks').terminal()
        end,
        desc = 'Toggle Floating Terminal',
      },
    },
  },
}
