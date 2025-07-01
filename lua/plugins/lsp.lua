return {
  {'folke/tokyonight.nvim'},
  {'mason-org/mason.nvim', tag = 'v1.11.0', pin = true},
  {'mason-org/mason-lspconfig.nvim', tag = 'v1.32.0', pin = true},
  {'neovim/nvim-lspconfig', tag = 'v1.8.0', pin = true},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  { "jose-elias-alvarez/nvim-lsp-ts-utils", dependencies = { "neovim/nvim-lspconfig" }},
}
