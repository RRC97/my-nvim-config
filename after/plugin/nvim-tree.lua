-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeOpen)
vim.keymap.set("n", "<leader><S-e>", vim.cmd.NvimTreeClose, { desc = "Toggle Nvim Tree" })
-- vim.keymap.set("n", "<leader>b", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>q", "<cmd>tabclose<CR>", { desc = "Fechar tab atual" })

-- vim.api.nvim_create_autocmd("TabNewEntered", {
--   callback = function()
--     local view = require("nvim-tree.view")
--     if not view.is_visible() then
--       require("nvim-tree.api").tree.open()
--     end
--   end,
-- })

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Deixa <CR> padrão (não precisa mapear)

  -- Mapeia t para abrir em nova tab
  vim.keymap.set("n", "t", function()
    local node = api.tree.get_node_under_cursor()
    if node and not node.nodes then -- verifica se não é diretório
      vim.cmd("tabnew " .. vim.fn.fnameescape(node.absolute_path))
    end
  end, opts("abrir arquivo em nova tab"))

  vim.keymap.set("n", "<leader>e", function()
    vim.cmd("wincmd w")
  end, {buffer = bufnr})
end


require("nvim-tree").setup({
  on_attach = on_attach,
  update_focused_file = { enable = true },
})

vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    require("nvim-tree.api").tree.open()
    vim.cmd("wincmd p")
  end,
})

-- OR setup with some options
-- require("nvim-tree").setup({
--   sort = {
--     sorter = "case_sensitive",
--   },
--   view = {
--     width = 30,
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })
