return {
	"tpope/vim-fugitive",
	-- Optional configuration:
	config = function()
		-- Configure fugitive here if needed.
		-- For example, to set a specific diff command:
		vim.g.fugitive_diff_cmd = "git difftool"
	end,
	-- Optional keymaps:
	keys = {
		-- Example: Map `<leader>gs` to `:G` (status)
		{ "<leader>gs", "<cmd>G<cr>", desc = "Fugitive Status" },
	},
}
