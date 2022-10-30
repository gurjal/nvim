local opt = vim.opt
local M = {}

local user_scrolloff = nil

local init = function() user_scrolloff = opt.scrolloff:get() end

M.toggle = function()
    if user_scrolloff == nil then init() end
    if opt.scrolloff:get() ~= user_scrolloff then
        opt.scrolloff = user_scrolloff
        require("notify")("scroll mode is off")
    else
        opt.scrolloff = 9999
        require("notify")("scroll mode is on")
    end
end

return M
