require('Comment').setup()

-- Modo normal
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment line" })

-- Modo visual
vim.keymap.set("x", "<C-/>", "gc", { remap = true, desc = "Toggle comment selection" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment visual mode" })
