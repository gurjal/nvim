local opt = vim.opt

local m = {}

local alive = false

local status = false

local options = {
    bufferline = false, -- enable bufferline
    bufferline_settings = {
        exclude_terminal = false, -- don't show terminal buffers in bufferline
        show_index = false, -- show buffer indexes (not the actual buffer numbers) in bufferline
    },
    theme = "default", -- change theme
    sections = { -- define sections
        -- { class = "mode", item = require("hardline.parts.mode").get_item },
        { class = "high", item = require("hardline.parts.git").get_item, hide = 100 },
        { class = "med", item = require("hardline.parts.filename").get_item },
        "%<",
        { class = "med", item = "%=" },
        { class = "low", item = require("hardline.parts.wordcount").get_item, hide = 100 },
        { class = "error", item = require("hardline.parts.lsp").get_error },
        { class = "warning", item = require("hardline.parts.lsp").get_warning },
        { class = "warning", item = require("hardline.parts.whitespace").get_item },
        { class = "high", item = require("hardline.parts.filetype").get_item, hide = 60 },
        { class = "mode", item = require("hardline.parts.line").get_item },
    },
}

local load = function()
    require("packer").loader("nvim-hardline")
end

local init = function()
    m.alive = true
    require("hardline").setup(options)
end

m.toggle = function()
    if status == false then
        if alive == false then
            -- load()
            init()
        end
        opt.laststatus = 3
        status = true
    else
        opt.laststatus = 0
        status = false
    end
end

return m
