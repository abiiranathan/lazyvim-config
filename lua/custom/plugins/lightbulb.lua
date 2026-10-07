-- Lightbulb indicator: shows a sign when a Quick Fix is available at the cursor,
-- so `<leader>.` never feels dead.
return {
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    config = function()
      require('nvim-lightbulb').setup {
        autocmd = { enabled = true },
        sign = { enabled = true },
        float = { enabled = false },
        virtual_text = { enabled = false },
        status_text = { enabled = false },
      }
    end,
  },
}
