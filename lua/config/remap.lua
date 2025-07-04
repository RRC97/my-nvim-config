vim.g.mapleader = " "

-- ZZ → sair sem salvar (como :qa)
vim.keymap.set('n', 'ZZ', ':qa<CR>', { desc = 'Fechar tudo sem salvar' })

-- ZX → salva tudo e sai (como :wa | qa)
vim.keymap.set('n', 'ZX', ':wqa<CR>', { desc = 'Salvar tudo e sair' })

vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = 'Buffer next' })
vim.keymap.set('n', '<C-k>', ':bprevious<CR>', { desc = 'Buffer previous' })

-- Normal mode: copiar linha atual para clipboard
vim.keymap.set('n', '<C-c>', '"+yy', { noremap = true, silent = true })

-- Visual mode: copiar seleção para clipboard
vim.keymap.set('x', '<C-c>', '"+y', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rn", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative number" })

