function OpenFloatingTerminal()
    local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer

    -- Get the dimensions of the current Neovim window
    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    -- Calculate the size of the floating window
    local win_width = math.ceil(width * 0.8)
    local win_height = math.ceil(height * 0.8)
    local row = math.ceil((height - win_height) / 2)
    local col = math.ceil((width - win_width) / 2)

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    -- Open a terminal in the floating window
    local term_job_id = vim.fn.termopen(vim.o.shell, {
        on_exit = function()
            vim.api.nvim_win_close(win, true) -- Close the floating window
            vim.api.nvim_buf_delete(buf, { force = true }) -- Delete the buffer
        end,
    })

    -- Set terminal options
    vim.api.nvim_command('startinsert') -- Start terminal in insert mode
end

vim.api.nvim_set_keymap('n', '<leader>z', ':lua OpenFloatingTerminal()<CR>', { noremap = true, silent = true })
