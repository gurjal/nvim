local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd 'neovim-ayu'
require('ayu').setup {
    overrides = {
        Normal   = {bg = '#0f1419'},
        NormalNC = {bg = '#0f1419'},
        SignColumn = {bg = '#0f1419'},
    }
}
colorscheme 'ayu-dark'
