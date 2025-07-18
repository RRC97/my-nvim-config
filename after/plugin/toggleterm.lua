require('toggleterm').setup()

vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true })
