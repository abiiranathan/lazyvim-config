return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events. Skips special buffers (help, terminals,
      -- file explorers, diffview/neogit panels...) so UIs never trigger
      -- linter binaries.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.buftype ~= '' then
            return
          end
          local ft = vim.bo.filetype
          if ft == '' or ft:match('^Diffview') or ft:match('^Neogit') or ft:match('^neo%-tree') then
            return
          end
          require('lint').try_lint()
        end,
      })
    end,
  },
}
