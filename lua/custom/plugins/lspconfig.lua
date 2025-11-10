return { -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    -- LSP Attach event handler
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Navigation mappings
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

        -- Symbol search
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Code actions and refactoring
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, '[F]ormat')

        -- Quick fix - like VS Code's Ctrl+.
        map('<leader>.', vim.lsp.buf.code_action, 'Quick [F]ix / Code Action')
        map('<C-.>', vim.lsp.buf.code_action, 'Quick [F]ix / Code Action (VS Code style)')

        -- Auto-fix - apply first available code action automatically
        map('<leader>af', function()
          vim.lsp.buf.code_action {
            filter = function(action)
              return action.isPreferred
                or string.match(action.title:lower(), 'fix')
                or string.match(action.title:lower(), 'import')
            end,
            apply = true,
          }
        end, '[A]uto [F]ix')

        -- Source code actions (organize imports, etc.)
        map('<leader>so', function()
          vim.lsp.buf.code_action {
            context = {
              only = { 'source.organizeImports' },
            },
            apply = true,
          }
        end, '[S]ource [O]rganize imports')

        map('<leader>sa', function()
          vim.lsp.buf.code_action {
            context = {
              only = { 'source' },
            },
          }
        end, '[S]ource [A]ctions')

        --  LSP hover
        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
        end, { desc = "LSP Hover documentation" })

        -- Diagnostics and Quickfix mappings
        map('<leader>e', vim.diagnostic.open_float, 'Show lin[E] diagnostics')
        map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')
        map('<leader>Q', vim.diagnostic.setqflist, 'Open workspace diagnostic [Q]uickfix list')
        map('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
        map(']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')

        -- Quickfix list navigation
        map('<leader>qo', '<cmd>copen<CR>', '[Q]uickfix [O]pen')
        map('<leader>qc', '<cmd>cclose<CR>', '[Q]uickfix [C]lose')
        map('<leader>qn', '<cmd>cnext<CR>', '[Q]uickfix [N]ext')
        map('<leader>qp', '<cmd>cprev<CR>', '[Q]uickfix [P]revious')
        map('<leader>qf', '<cmd>cfirst<CR>', '[Q]uickfix [F]irst')
        map('<leader>ql', '<cmd>clast<CR>', '[Q]uickfix [L]ast')

        -- Location list navigation
        map('<leader>lo', '<cmd>lopen<CR>', '[L]ocation list [O]pen')
        map('<leader>lc', '<cmd>lclose<CR>', '[L]ocation list [C]lose')
        map('<leader>ln', '<cmd>lnext<CR>', '[L]ocation list [N]ext')
        map('<leader>lp', '<cmd>lprev<CR>', '[L]ocation list [P]revious')

        -- Toggle features
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method('textDocument/inlayHint') then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end

        -- Document highlighting setup
        if client and client.supports_method('textDocument/documentHighlight') then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    -- Configure diagnostic display
    vim.diagnostic.config {
      virtual_text = {
        prefix = '●',
        source = 'if_many',
      },
      float = {
        source = 'always',
        border = 'rounded',
        format = function(diagnostic)
          local message = diagnostic.message
          if diagnostic.code then
            message = string.format('%s [%s]', message, diagnostic.code)
          end
          return message
        end,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    -- LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    -- Server configurations
    local servers = {
      clangd = {
        cmd = {
          'clangd',
          '--suggest-missing-includes',
          '--background-index',
          '--enable-config',
          '--clang-tidy',
          '--offset-encoding=utf-16',
          '--fallback-style=Google',
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      },
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
      emmet_language_server = {
        cmd = { 'emmet-language-server', '--stdio' },
        filetypes = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      },
      cssls = {},
      htmx = {},
      html = {
        filetypes = { 'html', 'templ', 'gohtml', 'gotmpl' },
      },
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = true },
          },
        },
      },
      tailwindcss = {
        cmd = { 'tailwindcss-language-server', '--stdio' },
        filetypes = { 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
      },
      svelte = {
        cmd = { 'svelteserver', '--stdio' },
        filetypes = { 'svelte' },
      },
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              disable = { 'missing-fields' },
              globals = { 'vim' },
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      templ = {
        cmd = { 'templ', 'lsp' },
        filetypes = { 'templ' },
      },
    }

    -- Setup Mason
    require('mason').setup {
      ui = {
        border = 'rounded',
      },
    }

    -- Tools to ensure are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = true,
    }

    -- Setup LSP servers
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
