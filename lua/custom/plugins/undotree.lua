-- Undo tree: visual history of every edit, beyond linear u/Ctrl-r.
return {
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = '[U]ndo tree' },
    },
  },
}
