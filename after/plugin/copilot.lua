vim.g.copilot_no_tab_map = true -- desativa mapeamento padrão no <Tab>

vim.g.copilot_filetypes = {
  ["TelescopePrompt"] = false,
  [""] = false, -- buffers sem tipo
}

_G.copilot_enabled = true

function ToggleCopilot()
  if _G.copilot_enabled then
    vim.cmd('Copilot disable');
    _G.copilot_enabled = false
    print("Copilot desativado")
  else
    vim.cmd('Copilot enable');
    _G.copilot_enabled = true
    print("Copilot ativado")
  end
end



-- Map para <Leader>c ativar/desativar manualmente
vim.api.nvim_set_keymap(
  'n',
  '<Leader>c',
  '<Cmd>lua ToggleCopilot()<CR>',
  { noremap = true, silent = true }
)

vim.cmd [[
  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
]]
