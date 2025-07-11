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

vim.keymap.set("n", "<C-j>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-k>", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>bq", ":bufdo bd<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>ba", ":new<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bo", ":only<CR>", { desc = "Quit other windows" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>cq", function()
  -- if there are no diagnostics, do nothing or close quickfix opened
  if vim.tbl_isempty(vim.diagnostic.get(0)) then
    vim.cmd("cclose")
  else
    vim.diagnostic.setqflist()
    vim.cmd("copen")
    vim.cmd("wincmd p")
  end
end, { desc = "Abrir quickfix com diagnostics" })

vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Fechar tab atual" })

vim.keymap.set("n", "<CR>", "o<Esc>", { desc = "Open new line below", remap = true, silent = true })
vim.keymap.set("n", "<leader><CR>", "<S-o><Esc>", { desc = "Open new line above", remap = true, silent = true })

-- Normal mode: copiar linha atual para clipboard
-- vim.keymap.set('n', '<C-c>', '"+yy', { noremap = true, silent = true })

-- Visual mode: copiar seleção para clipboard
-- vim.keymap.set('x', '<C-c>', '"+y', { noremap = true, silent = true })

-- Insert mode: colar do clipboard
-- vim.keymap.set('i', '<C-v>', '<C-o>"+p', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>rn", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative number" })

-- vim.keymap.set('n', '<leader>rc', ':edit $MYVIMRC<CR>', { desc = "Editar init.lua" })
-- vim.keymap.set('n', '<leader>t', ':new | term<CR>', { desc = "Abrir terminal" })
