local startup_cwd = vim.fn.getcwd()

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
      function() vim.cmd("rshada!") end,
      function()
        -- Restaura o CWD para o diretório em que o Neovim foi iniciado
        vim.cmd("cd " .. vim.fn.fnameescape(startup_cwd))

        -- Garante a sincronização do nvim-tree se o plugin estiver carregado
        local has_tree, api = pcall(require, "nvim-tree.api")
        if has_tree then
          api.tree.change_root(startup_cwd)
        end
      end
    },
    session_lens = {
      picker = "telescope",
    },
  },
}
