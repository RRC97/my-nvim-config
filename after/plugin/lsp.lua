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

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gh', vim.diagnostic.open_float, opts)
    -- vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>=', function() vim.lsp.buf.format({ async = true }) end, opts)
    -- vim.keymap.set('n', '<leader>io', function()
    --   vim.lsp.buf.code_action({
    --     context = {
    --       only = {
    --         "source.addMissingImports",
    --         "source.organizeImports",
    --         "source.removeUnused",
    --       },
    --       diagnostics = {}
    --     },
    --     apply = true,
    --   })
    -- end, opts)
    -- vim.keymap.set({"n", "v"}, "<leader>ii", function ()
    --   vim.lsp.buf.code_action({
    --     context = { only = { "quickfix" } },
    --     apply = true,
    --   })
    -- end, opts)
    -- vim.keymap.set('n', '<leader>ia', function()
    --   vim.lsp.buf.code_action({
    --     context = { only = { "source.fixAll" } },
    --     apply = true,
    --   })
    -- end, opts)
  end,
})

-- Mason
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls', -- Lua
    -- 'pyright', -- Python
    'ts_ls',  -- TypeScript/JavaScript
    -- 'gopls', -- Go
    -- 'rust_analyzer', -- Rust
    -- 'clangd', -- C/C++
    'html',         -- HTML
    'cssls',        -- CSS
    'jsonls',       -- JSON
    'intelephense', -- PHP
  },
  automatic_installation = true,
})

-- Carrega todos os LSPs instalados, mesmo os fora do ensure_installed
local lspconfig = require('lspconfig')
local servers = require('mason-lspconfig').get_installed_servers()

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

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
    ["<C-Space>"] = cmp.mapping.complete(), -- aqui você também ativa via cmp
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
  }),
})
