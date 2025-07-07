vim.opt.signcolumn = 'yes'

-- Capabilities para o LSP + cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Atalho para abrir autocomplete no insert
vim.keymap.set('i', '<C-\\>', function()
  require('cmp').complete()
end, { desc = 'Forçar autocomplete', silent = true })

-- LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references()
      vim.cmd("copen")
    end, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gh', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>=', function() vim.lsp.buf.format({async = true}) end, opts)
    vim.keymap.set('n', '<f4>', vim.lsp.buf.code_action, opts)
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
    end, opts)
  end,
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
  ensure_installed = {
    'lua_ls', -- Lua
    -- 'pyright', -- Python
    'ts_ls', -- TypeScript/JavaScript
    -- 'gopls', -- Go
    -- 'rust_analyzer', -- Rust
    -- 'clangd', -- C/C++
    'html', -- HTML
    'cssls', -- CSS
    'jsonls', -- JSON
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
    ["<C-j>"] = cmp.mapping.select_next_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<C-k>"] = cmp.mapping.select_prev_item({
      behavior = cmp.SelectBehavior.Insert,
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.complete(), -- aqui você também ativa via cmp
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})
