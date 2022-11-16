local opt = vim.opt
local M = {}

M.toggle = function()
    if opt.cmdheight:get() == 0 then
        opt.cmdheight = 1
        require("notify")("cmdheight is 1")
    else
        opt.cmdheight = 0
        require("notify")("cmdheight is 0")
    end
end

return M
