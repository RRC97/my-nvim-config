local harpoon = require("harpoon")

harpoon.setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>o", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)

vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
