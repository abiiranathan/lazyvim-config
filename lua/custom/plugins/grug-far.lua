-- Project-wide find & replace UI (like VSCode's Ctrl+Shift+H panel).
-- NOTE: <leader>sr is Telescope-resume, so this lives on <leader>sR.
return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = 'GrugFar',
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        '<leader>sR',
        function()
          require('grug-far').open()
        end,
        desc = '[S]earch & [R]eplace (project)',
      },
    },
  },
}
