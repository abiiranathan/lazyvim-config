return {
  name = 'keymap-export',
  dir = vim.fn.stdpath('config'),
  lazy = true,
  cmd = 'ExportKeymaps',
  config = function()
    local keymap_export = require('custom.keymap-export')
    keymap_export.setup()
  end,
}
