-- lua/plugins/floating-terminal.lua
return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- Add any global toggleterm options here if needed
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
    
    -- Create the floating terminal instance
    local Terminal = require('toggleterm.terminal').Terminal
    local float_term = Terminal:new({
      cmd = vim.o.shell,
      hidden = true,
      direction = 'float',
      float_opts = {
        border = 'rounded',
        winblend = 0, -- Transparency level (0-100, where 100 is fully transparent)
      },
      on_open = function(term)
        -- Set up keymaps when terminal opens
        local opts_local = { buffer = term.bufnr, noremap = true, silent = true }
        
        -- Close terminal on <Esc> in terminal mode
        vim.keymap.set('t', '<Esc>', function()
          term:close()
        end, opts_local)
        
        -- Also allow <Esc> in normal mode within the terminal buffer
        vim.keymap.set('n', '<Esc>', function()
          term:close()
        end, opts_local)
        
        -- Close on 'q' in normal mode (optional convenience)
        vim.keymap.set('n', 'q', function()
          term:close()
        end, opts_local)
      end,
    })
    
    -- Define the toggle function
    local function toggle_floating_terminal()
      float_term:toggle()
    end
    
    -- Map <leader>z to toggle the floating terminal
    vim.keymap.set(
      'n',
      '<leader>z',
      toggle_floating_terminal,
      { noremap = true, silent = true, desc = 'Toggle Floating Terminal' }
    )
    
    -- Set up autocommand to close terminal when clicking outside
    vim.api.nvim_create_autocmd('WinLeave', {
      callback = function()
        -- Check if the window we're leaving is the float terminal
        if float_term:is_open() then
          local current_win = vim.api.nvim_get_current_win()
          local term_win = float_term.window
          -- If we're leaving the terminal window, close it
          if term_win and current_win ~= term_win then
            float_term:close()
          end
        end
      end,
      desc = 'Close floating terminal when clicking outside',
    })
  end,
}
