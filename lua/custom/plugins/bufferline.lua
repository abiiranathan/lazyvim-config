-- Buffer tabs (like VSCode): see all open buffers, click or jump between them.
return {
  {
    'akinsho/bufferline.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        offsets = {
          { filetype = 'neo-tree', text = 'File Explorer', highlight = 'Directory', text_align = 'left' },
        },
        separator_style = 'slant',
      },
    },
    keys = {
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      {
        '<leader>bd',
        function()
          require('snacks').bufdelete()
        end,
        desc = '[B]uffer [D]elete',
      },
      {
        '<leader>bo',
        function()
          require('snacks').bufdelete.other()
        end,
        desc = 'Delete [O]ther buffers',
      },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = '[B]uffer [P]in' },
    },
  },
}
