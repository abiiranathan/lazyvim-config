-- Yank history: every yank is kept, cycle with [y/]y, browse with <leader>sp.
return {
  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('yanky').setup { highlight = { on_put = true, timer = 200 } }
      require('telescope').load_extension('yank_history')
    end,
    keys = {
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank (history)' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put after (history)' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put before (history)' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put after + cursor' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put before + cursor' },
      { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle yank forward' },
      { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle yank backward' },
      {
        '<leader>sp',
        function()
          require('telescope').extensions.yank_history.yank_history()
        end,
        desc = '[S]earch yank history ([P]aste)',
      },
    },
  },
}
