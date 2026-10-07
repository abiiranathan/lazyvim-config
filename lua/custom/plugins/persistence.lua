-- Session restore: reopen a project exactly where you left off.
-- NOTE: <leader>ql stays as quickfix-last; session-last is intentionally omitted.
return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        desc = 'Restore [S]ession (cwd)',
      },
      {
        '<leader>qS',
        function()
          require('persistence').select()
        end,
        desc = 'Select session',
      },
      {
        '<leader>qd',
        function()
          require('persistence').stop()
        end,
        desc = "Don't save session",
      },
    },
  },
}
