-- Quick Fix menu with diff preview (what each fix will do before you apply it).
return {
  {
    'aznhe21/actions-preview.nvim',
    event = 'LspAttach',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('actions-preview').setup {
        diff = { ctxlen = 3 },
        backend = { 'telescope', 'nui' },
        telescope = require('telescope.themes').get_dropdown(),
      }
    end,
  },
}
