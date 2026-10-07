return {                -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
    opts = {},
    keys = {
        { "<leader>c",  group = "[C]ode" },
        { "<leader>d",  group = "[D]ocument" },
        { "<leader>h",  group = "Git [H]unk" },
        { "<leader>r",  group = "[R]ename" },
        { "<leader>s",  group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>f",  group = "[F]loating / [F]ile" },
        { "<leader>m",  group = "[M]ulticursor" },
        { "<leader>sn", group = "[S]earch [N]oice" },
        { "<leader>t",  group = "[T]oggle" },
        { "<leader>w",  group = "[W]orkspace" },

        -- Visual mode
        { "<leader>h",  desc = "Git [H]unk",  mode = "v" }
    },
}
