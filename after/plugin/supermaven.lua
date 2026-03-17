require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<C-l>",
    clear_suggestion = "<M-[>",
    accept_word = "<M-]>",
  },
  ignore_filetypes = { cpp = true },
  color = {
    suggestion_color = "#808080",
    cterm = 244,
  },
  log_level = "info",
  disable_inline_completion = false,
  disable_keymaps = false,
  condition = function()
    return false
  end
})
