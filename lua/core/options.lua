local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- base
opt.number = true
opt.relativenumber = true
opt.syntax = "enable"
opt.tabstop = 4
opt.shiftwidth = 0
opt.expandtab = true
opt.textwidth = 100
opt.wrap = false
opt.wrapmargin = 0
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = false
opt.showmode = false
opt.mouse = "a"

-- window
opt.cmdheight = 1
opt.showtabline = 1
opt.numberwidth = 4
opt.laststatus = 0
opt.signcolumn = "yes:1"
opt.title = true
opt.titleold = "st"
opt.splitbelow = false
opt.splitright = false
opt.termguicolors = true

-- backup, undo and swap
opt.undofile = true
opt.undodir = vim.fn.stdpath("cache") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.writebackup = true

-- util
opt.timeoutlen = 400
opt.shortmess:append("sI")
opt.compatible = false
cmd("filetype plugin indent on")
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = { "list", "longest" }
opt.hidden = true
opt.list = true
opt.lazyredraw = false

-- formatting
opt.formatoptions = "tcrql"
opt.joinspaces = false
g.rust_recommended_style = 0

g.mapleader = " "

-- disable some builtin vim plugins
local default_plugins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(default_plugins) do
    g["loaded_" .. plugin] = 1
end

local default_providers = {
    "node",
    "perl",
    "python3",
    "ruby",
}

for _, provider in ipairs(default_providers) do
    g["loaded_" .. provider .. "_provider"] = 0
end
