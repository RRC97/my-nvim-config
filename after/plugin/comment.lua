require('Comment').setup()

-- Modo normal
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })

-- Modo visual
vim.keymap.set("x", "<C-_>", "gc", { remap = true, desc = "Toggle comment selection" })
