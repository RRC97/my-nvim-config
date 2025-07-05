vim.opt.signcolumn = 'yes'

-- Capabilities para o LSP + cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Atalho para abrir autocomplete no insert
vim.keymap.set('i', '<C-\\>', function()
  require('cmp').complete()
end, { desc = 'Forçar autocomplete', silent = true })

-- LSP attach
vim.api.nvim_create_autocmd('lspattach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references()
      vim.cmd("copen")
    end, opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', 'gh', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    vim.keymap.set('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>=', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<f4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>io', function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
    end, opts)
    vim.keymap.set('n', '<leader>ia', function()
      vim.lsp.buf.code_action({
        context = { only = { "quickfix" } },
        apply = true,
      })
    end, { desc = "Add Missing Imports" })
  end,
})

-- Configuração dos servers
require('lspconfig').lua_ls.setup({
  capabilities = capabilities,
})
require('lspconfig').ts_ls.setup({ -- CORRIGIDO o nome do server
  capabilities = capabilities,
})

-- Mason
require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = capabilities,
      })
    end,
  },
})

-- CMP config
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      -- precisa do neovim 0.10 para isso
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(), -- aqui você também ativa via cmp
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})
