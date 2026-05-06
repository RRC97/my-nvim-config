return {
  "rmagatti/auto-session",
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_save = true,
    auto_restore = true,
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    -- Hook essencial: Salva o arquivo Shada (que contém a jumplist) ANTES de salvar a sessão
    pre_save_cmds = {
      "NvimTreeClose",
      function() vim.cmd("wshada") end
    },
    -- Hook essencial: Lê o arquivo Shada LOGO APÓS carregar a sessão
    post_restore_cmds = {
      function() vim.cmd("rshada!") end
    },
    session_lens = {
      picker = "telescope",
    },
  },
}
