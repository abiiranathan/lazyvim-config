-- True multiple cursors (VSCode-style Ctrl+D / Alt+arrows).
-- See `:Cheatsheet multicursor` for the full guide.
return {
  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    event = 'VeryLazy',
    config = function()
      local mc = require 'multicursor-nvim'
      mc.setup()

      local set = vim.keymap.set

      -- Add a cursor on the line above/below (Alt+arrows; Ctrl+arrows resize windows).
      set({ 'n', 'x' }, '<M-Up>', function()
        mc.lineAddCursor(-1)
      end, { desc = 'Multicursor: add cursor line up' })
      set({ 'n', 'x' }, '<M-Down>', function()
        mc.lineAddCursor(1)
      end, { desc = 'Multicursor: add cursor line down' })
      set({ 'n', 'x' }, '<leader><up>', function()
        mc.lineSkipCursor(-1)
      end, { desc = 'Multicursor: skip line up' })
      set({ 'n', 'x' }, '<leader><down>', function()
        mc.lineSkipCursor(1)
      end, { desc = 'Multicursor: skip line down' })

      -- Add/skip cursors by matching word under cursor (normal) or selection (visual).
      set({ 'n', 'x' }, '<leader>mn', function()
        mc.matchAddCursor(1)
      end, { desc = '[M]ulticursor: add next match' })
      set({ 'n', 'x' }, '<leader>mN', function()
        mc.matchAddCursor(-1)
      end, { desc = '[M]ulticursor: add previous match' })
      set({ 'n', 'x' }, '<leader>ms', function()
        mc.matchSkipCursor(1)
      end, { desc = '[M]ulticursor: skip next match' })
      set({ 'n', 'x' }, '<leader>mS', function()
        mc.matchSkipCursor(-1)
      end, { desc = '[M]ulticursor: skip previous match' })
      set({ 'n', 'x' }, '<leader>ma', mc.matchAllAddCursors, { desc = '[M]ulticursor: add ALL matches' })
      set('n', '<leader>mv', mc.restoreCursors, { desc = '[M]ulticursor: restore cursors' })
      set({ 'n', 'x' }, '<leader>mc', mc.clearCursors, { desc = '[M]ulticursor: clear cursors' })

      -- Mouse: Ctrl+click adds a cursor, Ctrl+drag adds them in an area.
      set('n', '<c-leftmouse>', mc.handleMouse)
      set('n', '<c-leftdrag>', mc.handleMouseDrag)
      set('n', '<c-leftrelease>', mc.handleMouseRelease)

      -- Toggle cursors on/off without losing them.
      set({ 'n', 'x' }, '<c-q>', mc.toggleCursor, { desc = 'Multicursor: toggle cursors' })

      -- These only apply while multiple cursors are active.
      mc.addKeymapLayer(function(layerSet)
        -- Jump between cursors.
        layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
        layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
        -- Delete the main cursor.
        layerSet({ 'n', 'x' }, '<leader>mx', mc.deleteCursor)
        -- Esc toggles: disabled cursors -> enable, enabled -> clear all.
        layerSet('n', '<esc>', function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Cursor visuals.
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { reverse = true })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      hl(0, 'MultiCursorDisabledCursor', { reverse = true })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },
}
