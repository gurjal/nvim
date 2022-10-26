local g = vim.g
local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd("embark")
g.embark_terminal_italics = 1
colorscheme("embark")
