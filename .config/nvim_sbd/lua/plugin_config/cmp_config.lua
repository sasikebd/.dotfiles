-- plugin : hrsh7th/nvim-cmp

local M = {}

M.FLAG_INCLUDE = false

M.Setup = function()

  if M.FLAG_INCLUDE then

    local cmp = require("cmp")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-o>'] = cmp.mapping.complete()(-4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true}),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lps'},
        { name = 'buffer'},
      }),

    })
  end
end

return M
