local opt = vim.opt
local M = {}

local note_width = 60
local normal_width = nil

M.toggle = function()
    if normal_width == nil then
        normal_width = opt.textwidth
        opt.textwidth = note_width
        opt.formatoptions:append({ "a" })
        require("notify")("note mode is on")
    else
        opt.textwidth = normal_width
        normal_width = nil
        opt.formatoptions:remove({ "a" })
        require("notify")("note mode is off")
    end
end

return M
