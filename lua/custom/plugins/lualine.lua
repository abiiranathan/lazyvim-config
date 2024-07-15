return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require('lualine').setup({
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        file_status = true,
                        path = 2
                    }
                }
            },

        })
    end
}
