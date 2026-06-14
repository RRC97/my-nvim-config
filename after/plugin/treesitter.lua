
require('nvim-treesitter').setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require('nvim-treesitter').install {
    "html", "css", "javascript",
    "typescript", "tsx",
    "php", "blade",
    "json", "yaml", "lua",
    "markdown", "markdown_inline"
}
