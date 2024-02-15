local M = {}

M.FLAG_INCLUDE = true

M.Setup = function()

  if M.FLAG_INCLUDE then
    --require'lspconfig'.pyright.setup{}
    --
    -- setup mason here 
    require("mason").setup()

    -- setup mason-lspconfig here
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright","clangd","bashls"},

      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --    Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      ---@type boolean
      automatic_installation = true,

      -- See `:h mason-lspconfig.setup_handlers()`
      ---@type table<string, fun(server_name: string)>?
      handlers  = nil
     })

    --[[ Autocompletion related setups]]
    local lspconfig = require('lspconfig')

    -- Additonal configuration for autocompletion nvm-cmp -- 
    -- ref : https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    ----SBDDEL_S
    --capabilities.textDocument.completion.completionItem = {
    --    documentationFormat = { "markdown", "plaintext" },
    --    snippetSupport = true,
    --    preselectSupport = true,
    --    insertReplaceSupport = true,
    --    labelDetailsSupport = true,
    --    deprecatedSupport = true,
    --    commitCharactersSupport = true,
    --    tagSupport = { valueSet = { 1 } },
    --    resolveSupport = {
    --      properties = {
    --        "documentation",
    --        "detail",
    --        "additionalTextEdits",
    --      },
    --    },
    --  }

    ----SBDDEL_E

    -- define servers in serverconfiguration.md
    local servers = {'lua_ls', 'clangd', 'pyright', 'bashls' }

    -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
      }
    end

    -- luasnip setup
    local luasnip = require('luasnip')

    -- nvim-cmp setup
    local cmp = require('cmp')

    cmp.setup {

      --snippet configuration
      snippet = { expand = function(args)
         -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
         --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
         luasnip.lsp_expand(args.body) -- For `luasnip` users.
         -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },

    -- mapping configuration
    mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
      ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
      -- C-b (back) C-f (forward) for snippet placeholder navigation.
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),

    -- completion windows behavior
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    -- sources configuration
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      --{ name = 'buffer'},
    },

    formatting = { fields = {'abbr', 'menu', 'kind'},
          format = function(entry, item)
            local short_name = {
              nvim_lsp = 'LSP',
              nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
          end,
        }
      }

    -- Use buffer source for `/` and `?` (if enabled `native_menu`, this won't work anymore).
   cmp.setup.cmdline({ '/', '?' }, {
     mapping = cmp.mapping.preset.cmdline(),
     sources = {
       { name = 'buffer' }
     }
   })
--
--    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
--    cmp.setup.cmdline(':', {
--      mapping = cmp.mapping.preset.cmdline(),
--      sources = cmp.config.sources({
--        { name = 'path' },
--        { name = 'cmdline' },
--        })
--    })

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

    -- Other mappings
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function()
        local bufmap = function(mode, lhs, rhs)
          local opts = {buffer = true}
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        --Displays hover information about the symbol under the cursor
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

        -- Jump to the definition
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

        -- Jump to declaration
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

        -- Lists all the implementations for the symbol under the cursor
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

        -- Jumps to the definition of the type symbol
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

        -- Lists all the references 
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

        -- Displays a function's signature information
        bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

        -- Renames all references to the symbol under the cursor
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

        -- Selects a code action available at the current cursor position
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

        -- Show diagnostics in a floating window
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

        -- Move to the previous diagnostic
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

        -- Move to the next diagnostic
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
      end
    })

  end
end

return M
