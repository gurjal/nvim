local g = vim.g
local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd("vim-moonfly-colors")
g.moonflyCursorColor = 1
g.moonflyItalics = 1
colorscheme("moonfly")
