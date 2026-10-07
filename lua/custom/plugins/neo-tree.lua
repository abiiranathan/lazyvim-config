return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require('neo-tree').setup {
            window = {
                width = 30, -- default 40; keep the tree slim
            },
        }
        -- Keymap for neotree (Ctrl + B)
        vim.keymap.set("n", '<C-b>', ":Neotree toggle<CR>", { desc = 'Toggle file tree' })
    end
}
