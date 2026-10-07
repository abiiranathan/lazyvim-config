return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  -- "gcc" to comment or uncomment a single line
  -- "gcu" to uncomment visual regions/lines
  -- "gbc" for a block comment
  -- "gcap" to comment a paragraph
  { 'numToStr/Comment.nvim', opts = {} },

  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- NOTE: gz prefix (not s) so flash.nvim can own `s` for jumping.
      -- - gzaw) - [G]o [Z]urround [A]dd [I]nner [W]ord [)]Paren
      -- - gzd'   - [G]o [Z]urround [D]elete [']quotes
      -- - gzr)'  - [G]o [Z]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gza',
          delete = 'gzd',
          find = 'gzf',
          find_left = 'gzF',
          highlight = 'gzh',
          replace = 'gzr',
          update_n_lines = 'gzn',
        },
      }
      -- Bracketed textobjects ([b/]b and [y/]y disabled: owned by
      -- bufferline and yanky respectively, avoids load-order flakiness)
      require('mini.bracketed').setup {
        buffer = { suffix = '' },
        yank = { suffix = '' },
      }
      -- Indent guides (nesting depth at a glance)
      require('mini.indentscope').setup()
    end,
  },
}
