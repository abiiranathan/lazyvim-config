-- Git UI: staging/committing (neogit) + history and diffs (diffview).
return {
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
    },
    opts = { integrations = { telescope = true, diffview = true } },
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit status' },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git [D]iff (working tree)' },
      { '<leader>gD', '<cmd>DiffviewFileHistory %<cr>', desc = 'File history' },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
}
