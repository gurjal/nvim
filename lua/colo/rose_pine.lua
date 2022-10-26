local packadd = vim.cmd.packadd
local colorscheme = vim.cmd.colorscheme
packadd("rose_pine")
require("rose-pine").setup({
    dark_variant = "moon",
})
colorscheme("rose-pine")
