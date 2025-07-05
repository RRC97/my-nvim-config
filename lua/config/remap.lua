vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ZZ → sair sem salvar (como :qa)
vim.keymap.set('n', 'ZZ', ':qa<CR>', { desc = 'Fechar tudo sem salvar' })
vim.keymap.set('n', 'ZQ', ':qa!<CR>', { desc = 'Fechar tudo sem salvar' })

-- ZX → salva tudo e sai (como :wa | qa)
vim.keymap.set('n', 'ZX', ':wqa<CR>', { desc = 'Salvar tudo e sair' })

vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = 'Buffer next' })
vim.keymap.set('n', '<C-k>', ':bprevious<CR>', { desc = 'Buffer previous' })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>ba", ":bufdo bd<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>bo", ":only<CR>", { desc = "Quit other windows" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>cq", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen") -- já abre o quickfix automaticamente
  vim.cmd("wincmd p") -- volta para o buffer anterior
end, { desc = "Abrir quickfix com diagnostics" })

vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>o", "o<Esc>", { desc = "Open new line below" })
vim.keymap.set("n", "<leader><S-o>", "<S-o><Esc>", { desc = "Open new line above" })

-- Normal mode: copiar linha atual para clipboard
vim.keymap.set('n', '<C-c>', '"+yy', { noremap = true, silent = true })

-- Visual mode: copiar seleção para clipboard
vim.keymap.set('x', '<C-c>', '"+y', { noremap = true, silent = true })

-- Insert mode: colar do clipboard
vim.keymap.set('i', '<C-v>', '<C-o>"+p', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rn", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative number" })

