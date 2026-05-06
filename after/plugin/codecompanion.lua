require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemini_cli",
    },
    inline = {
      adapter = "gemini_cli",
    },
  },
  display = {
    chat = {
      window = {
        layout = "vertical", -- Abre na lateral
        width = 0.4,         -- Proporção da tela
        position = "right",
      }
    }
  },
})

-- Atalhos
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "Toggle CodeCompanion Chat" })
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "CodeCompanion Actions" })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "Add to CodeCompanion Chat" })
