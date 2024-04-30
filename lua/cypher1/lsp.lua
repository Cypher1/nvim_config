local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('LspAttach', {
    group = augroup('user_lsp_attach', {clear = true}),
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', '<leader>h', function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
        vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
        pylsp = function()
            require('lspconfig').pylsp.setup({
                capabilities = lsp_capabilities,
                settings = {
                    pylsp = {
                      plugins = {
                        pycodestyle = {
                          enabled = true,
                          ignore = "W503,E501,C901",
                        },
                        mccabe = { enabled = false },
                        flake8 = {
                          enabled = true,
                          ignore = "W503,E501,C901",
                        },
                        ruff = { enabled = false },
                      }
                    }
                }
            })
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                capabilities = lsp_capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = {'vim'},
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
-- require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        -- {name = 'luasnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 3},
    },
    mapping = cmp.mapping.preset.insert({
        ['<S-tab>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
        ['<right>'] = cmp.mapping.complete(),
    }),
    -- snippet = {
        -- expand = function(args)
            -- require('luasnip').lsp_expand(args.body)
        -- end,
    -- },
})

