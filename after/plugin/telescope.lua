local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope git_commits<CR>", { desc = 'Telescope git commits' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
})
