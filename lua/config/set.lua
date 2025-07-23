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

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.o.clipboard = "unnamedplus"

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"

-- vim.opt.shell = "powershell.exe"
-- vim.opt.shellcmdflag = "-NoProfile -NoLogo -NonInteractive -Command"
-- vim.opt.shellpipe = "|"
-- vim.opt.shellredir = ">"
-- vim.opt.shellquote = "\""
-- vim.opt.shellxquote = ""

vim.cmd [[
  highlight LineNr guifg=#7f848e
  highlight CursorLineNr guifg=#e06c75 gui=bold
]]

vim.opt.guifont = "JetBrainsMonoNL Nerd Font:h10"
