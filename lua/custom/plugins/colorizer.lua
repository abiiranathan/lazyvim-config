-- Inline color preview for hex codes like #ff8800.
return {
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = { user_default_options = { names = false } },
  },
}
