local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd 'neovim-ayu'
require('ayu').setup {}
colorscheme 'ayu'
