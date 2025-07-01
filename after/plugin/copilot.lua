vim.g.copilot_no_tab_map = true -- desativa mapeamento padrão no <Tab>

vim.g.copilot_filetypes = {
  ["TelescopePrompt"] = false,
  [""] = false, -- buffers sem tipo
}

vim.cmd [[
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
]]
