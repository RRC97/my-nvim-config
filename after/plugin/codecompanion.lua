require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "gemini_cli",
    },
    inline = {
      adapter = "gemini",
    },
  },
  display = {
    action_palette = {
      provider = "telescope",
    },
    diff = {
      enabled = true,
      provider = "default",
    },
    chat = {
      window = {
        layout = "vertical", -- Abre na lateral
        width = 0.4,         -- Proporção da tela
        position = "right",
      }
    }
  },
  adapters = {
    acp = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend(
          "gemini_cli",
          {
            opts = {
              stream = true,
            }
          }
        )
      end,
    },
  },

})

local keymap = vim.keymap.set

-- Toggle chat
keymap("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", {
  desc = "Chat Toggle"
})

-- Novo chat
keymap("n", "<leader>cn", "<cmd>CodeCompanionChat<cr>", {
  desc = "New Chat"
})

-- Chats antigos
keymap("n", "<leader>cl", "<cmd>CodeCompanionChat List<cr>", {
  desc = "List Chats"
})

-- Actions
keymap({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", {
  desc = "Actions"
})

-- Adicionar seleção ao chat
keymap("v", "<leader>cs", "<cmd>CodeCompanionChat Add<cr>", {
  desc = "Send Selection"
})

-- Adicionar arquivo atual
keymap("n", "<leader>cf", function()
  local file = vim.fn.expand("%")
  vim.cmd("CodeCompanionChat Add " .. file)
end, {
  desc = "Add Current File"
})

-- Adicionar buffer atual
keymap("n", "<leader>cb", function()
  vim.cmd("CodeCompanionChat Add")
end, {
  desc = "Add Buffer"
})

-- Git diff
keymap("n", "<leader>cg", function()
  vim.cmd("CodeCompanionChat Add git")
end, {
  desc = "Add Git Diff"
})

-- Diagnostics
keymap("n", "<leader>cd", function()
  vim.cmd("CodeCompanionChat Add diagnostics")
end, {
  desc = "Add Diagnostics"
})
