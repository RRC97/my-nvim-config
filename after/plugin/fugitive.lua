vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "Fugitive Status" });
vim.keymap.set('n', '<leader>gl',
  '<cmd>Gllog --stat --pretty=format:"[%ad] %h - %s (%an)" --date=iso-strict | wincmd p <CR>', { silent = true })
vim.keymap.set('n', '<leader>gc', '<cmd>Gclog! | wincmd p<CR>', { silent = true })
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiff<CR>', { silent = true })
vim.keymap.set('n', '<leader>gD', '<cmd>Gvdiffsplit<CR>', { silent = true })
-- Fugitive key mappings

-- Próximo commit no Gdiff
vim.keymap.set('n', '<leader>gj', ':Gvdiffsplit HEAD~1<CR>', { silent = true })

-- Commit anterior no Gdiff
vim.keymap.set('n', '<leader>gk', ':Gvdiffsplit HEAD^<CR>', { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    -- Stage all
    vim.keymap.set("n", "A", ":Git add -A<CR>", { buffer = true })
  end,
})
