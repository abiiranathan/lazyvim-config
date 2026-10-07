-- Symbol outline sidebar: classes, functions, variables of the current file.
return {
  {
    'stevearc/aerial.nvim',
    cmd = 'AerialToggle',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {},
    keys = {
      { '<leader>co', '<cmd>AerialToggle<cr>', desc = '[C]ode [O]utline' },
    },
  },
}
