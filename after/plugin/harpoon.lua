local harpoon = require("harpoon")

harpoon.setup({
  settings = {
    save_on_toggle = true,
    save_on_change = true,
    save_on_ui_close = true,
  }
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>o", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)
vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end)
vim.keymap.set("n", "<leader>h0", function() harpoon:list():select(10) end)

vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
