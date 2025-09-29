local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({ no_ignore = false })
end, { desc = 'Telescope find files (gitignore on)' })
vim.keymap.set('n', '<leader>fF', builtin.find_files, { desc = 'Telescope find files (gitignore off)' })
vim.keymap.set('n', '<leader>fL', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fl', function()
  builtin.live_grep({ no_ignore = false })
end, { desc = 'Telescope live grep (gitignore off)' })
vim.keymap.set('n', '<leader>fg', builtin.git_commits, { desc = 'Telescope git commits' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>fs', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Telescope resume' })

local actions = require("telescope.actions")
-- local action_state = require("telescope.actions.state")

require("telescope").setup({
  pickers = {
    find_files = {
      follow = true,
      hidden = true,
      no_ignore = true,
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    live_grep = {
      no_ignore = true,
      -- additional_args = { '--no-ignore' }
    }
  },
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
