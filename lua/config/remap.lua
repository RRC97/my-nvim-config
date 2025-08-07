vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ZZ → sair sem salvar (como :qa)
vim.keymap.set('n', 'ZZ', ':qa<CR>', { desc = 'Fechar tudo sem salvar' })
vim.keymap.set('n', 'ZQ', ':qa!<CR>', { desc = 'Fechar tudo sem salvar' })

-- ZX → salva tudo e sai (como :wa | qa)
vim.keymap.set('n', 'ZX', ':wqa<CR>', { desc = 'Salvar tudo e sair' })

-- vim.keymap.set("n", "<C-j>", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<C-k>", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>bq", ":bufdo bd<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>ba", ":new<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#<CR>", { desc = "Quit other windows" })

vim.keymap.set("n", "<leader>cn", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>cq", function()
  -- if there are no diagnostics, do nothing or close quickfix opened
  local diagnostics = vim.diagnostic.get(0)
  if vim.tbl_isempty(diagnostics) then
    vim.cmd("cclose")
  else
    vim.diagnostic.setqflist({ open = false })
    vim.cmd("copen")
  end
end, { desc = "Abrir quickfix com diagnostics" })

vim.keymap.set("n", "<leader>q", ":tabclose<CR>", { desc = "Close current tab" })

vim.keymap.set("n", "<leader>ln", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>lp", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>rn", function()
  vim.o.relativenumber = not vim.o.relativenumber
end, { desc = "Toggle relative number" })

vim.keymap.set("n", "<C-CR>", "o<Esc>", { noremap = true, silent = true, desc = "Nova linha abaixo" })
vim.keymap.set("n", "<C-S-CR>", "O<Esc>", { noremap = true, silent = true, desc = "Nova linha acima" })

vim.keymap.set("n", "<leader><leader>", ":source $MYVIMRC<CR>", { desc = "Refresh config" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>cclose<CR>",
      { buffer = true, desc = "Close quickfix" })
  end,
})
