vim.g.mapleader = " "

-- ZZ → força sair sem salvar (como :qa!)
vim.keymap.set('n', 'ZZ', ':qa!<CR>', { desc = 'Fechar tudo sem salvar' })

-- ZX → salva tudo e sai (como :wa | qa)
vim.keymap.set('n', 'ZX', ':wqa<CR>', { desc = 'Salvar tudo e sair' })

vim.keymap.set('n', '<leader>j', ':bnext<CR>', { desc = 'Buffer next' })
vim.keymap.set('n', '<leader>k', ':bprevious<CR>', { desc = 'Buffer previous' })

