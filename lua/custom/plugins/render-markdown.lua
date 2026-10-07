-- Rendered markdown everywhere (hover docs, Cheatsheet popup, *.md files).
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- Eager (not ft-lazy): Diffview creates markdown buffers while plugins
    -- are still loading, and ft-timing races leave some buffers unattached.
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- Render inside diff windows too (e.g. Diffview/GitDiffView),
      -- otherwise markdown there stays raw. Upstream defaults this off.
      render = { diff = true },
    },
  },
}
