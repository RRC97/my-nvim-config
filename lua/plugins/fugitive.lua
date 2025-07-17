return {
	"tpope/vim-fugitive",
  lazy = false,
	-- Optional configuration:
	config = function()
		-- Configure fugitive here if needed.
		-- For example, to set a specific diff command:
		vim.g.fugitive_diff_cmd = "git difftool"
    vim.g.fuitive_git_args = { "--no-optional-locks" }
	end,
}
