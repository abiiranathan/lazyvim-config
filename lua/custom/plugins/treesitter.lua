return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = {
                'go', 'gomod', 'c', 'cpp', 'rust', 'python',
                'bash', 'lua', 'javascript', 'typescript',
                'html', 'css', 'scss', 'json', 'diff',
                'luadoc', 'markdown', 'vim', 'vimdoc',
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        })
    end,
}