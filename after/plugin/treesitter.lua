require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "html", "css", "javascript",
    "typescript", "tsx",
    "php", "blade",
    "json", "yaml", "markdown", "lua"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = { char = "│" },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    injected_languages = true,
    include = { node_type = { ["*"] = { "*" } } },
  },
})

require 'nvim-treesitter.configs'.setup { ... }

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade",
}

require('treesitter-context').setup({
  enable = true,
  max_lines = 3,
  trim_scope = "outer"
});

-- vim.filetype.add({
--   pattern = {
--     [".*%.blade%.php"] = "blade",
--   },
-- })
