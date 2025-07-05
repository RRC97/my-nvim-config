vim.opt.showmode = false;

vim.opt.nu = true;
vim.opt.relativenumber = true;

vim.opt.tabstop = 2;
vim.opt.softtabstop = 2;
vim.opt.shiftwidth = 2;
vim.opt.expandtab = true;

vim.opt.smartindent = true;

vim.opt.wrap = false;

vim.opt.swapfile = false
vim.opt.backup = false
local home = vim.fn.expand("~")
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'

vim.o.clipboard = "unnamedplus"

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"
