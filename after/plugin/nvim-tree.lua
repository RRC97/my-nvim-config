-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>e", function()
  require("nvim-tree.api").tree.open({path = vim.fn.getcwd()})
end)
-- vim.keymap.set("n", "<leader><S-e>", vim.cmd.NvimTreeClose, { desc = "Toggle Nvim Tree" })
-- vim.keymap.set("n", "<leader>b", vim.cmd.NvimTreeToggle)

-- vim.api.nvim_create_autocmd("TabNewEntered", {
--   callback = function()
--     local view = require("nvim-tree.view")
--     if not view.is_visible() then
--       require("nvim-tree.api").tree.open()
--     end
--   end,
-- })
local function open_win_config()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()

  -- Define desired window ratios (adjust as needed)
  local WIDTH_RATIO = 0.9
  local HEIGHT_RATIO = 0.9

  local window_w = screen_w * WIDTH_RATIO
  local window_h = screen_h * HEIGHT_RATIO

  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)

  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

  return {
    border = "rounded",     -- Optional: set border style
    relative = "editor",
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
  }
end

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  api.config.mappings.default_on_attach(bufnr)

  local harpoon = require("harpoon")

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
  end, opts("Open File In Tab"))

  vim.keymap.set("n", "<leader>a", function()
    local node = api.tree.get_node_under_cursor()
    if node and not node.nodes then -- verifica se não é diretório
      harpoon:list():add({
        value = vim.fn.fnamemodify(node.absolute_path, ":."),
        context = {
          col = 1,
          row = 1,
        }
      })
      vim.notify("Added to Harpoon: " .. node.name)
    end
  end, opts("Add File to Harpoon"))

  vim.keymap.set("n", "<leader>e", function()
    vim.cmd.NvimTreeClose()
  end, opts("Focus on File"))
  vim.keymap.set("n", "<leader>t", function()
    local node = api.tree.get_node_under_cursor()
    if node and node.nodes then
      vim.cmd("ToggleTerm dir=" .. vim.fn.fnameescape(node.absolute_path))
    end
  end, opts("Open In Terminal"))
end


require("nvim-tree").setup({
  view = {
    number = true,
    relativenumber = true,
    float = {
      enable = true,
      quit_on_focus_loss = true,
      open_win_config = open_win_config,
    },
  },
  on_attach = on_attach,
  update_focused_file = { enable = true },
  filters = {
    dotfiles = false,
    git_ignored = false,
    custom = { "\\.git$" }
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree" },
  callback = function()
    vim.b.treesitter_context_disabled = true
  end,
})
