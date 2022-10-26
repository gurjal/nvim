local g = vim.g
local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd("seoul256.vim")
g.seoul256_srgb=1
colorscheme("seoul256")
