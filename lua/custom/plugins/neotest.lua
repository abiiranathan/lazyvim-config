-- Test runner UI: run Go/Python tests from inside Neovim, see results inline.
return {
  {
    'nvim-neotest/neotest',
    cmd = 'Neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require('neotest-go'),
          require('neotest-python'),
        },
      }
    end,
    keys = {
      {
        '<leader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = '[T]est nearest',
      },
      {
        '<leader>tT',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = '[T]est file',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.run(vim.fn.getcwd())
        end,
        desc = 'Test [A]ll (cwd)',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Test [S]ummary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Test [O]utput',
      },
    },
  },
}
