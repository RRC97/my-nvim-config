return {
  {'folke/tokyonight.nvim'},
  {'mason-org/mason.nvim', pin = true},
  {'mason-org/mason-lspconfig.nvim', pin = true},
  {'neovim/nvim-lspconfig', pin = true},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  { "jose-elias-alvarez/nvim-lsp-ts-utils", dependencies = { "neovim/nvim-lspconfig" }},
}
