vim.keymap.set("n", "<leader>gs", "<cmd>G<CR>", { desc = "Fugitive Status"});
vim.keymap.set('n', '<leader>gl', '<cmd>Gllog --stat --pretty=format:"[%ad] %h - %s (%an)" --date=iso-strict | wincmd p <CR>', { silent = true })
vim.keymap.set('n', '<leader>gc', '<cmd>Gclog! | wincmd p<CR>', { silent = true })
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiff<CR>', { silent = true })
-- Próximo commit no Gdiff
vim.keymap.set('n', '<leader>gn', ':Gvdiffsplit HEAD~1<CR>', { silent = true })

-- Commit anterior no Gdiff
vim.keymap.set('n', '<leader>gp', ':Gvdiffsplit HEAD^<CR>', { silent = true })


