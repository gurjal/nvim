local opt = vim.opt
local M = {}

M.toggle = function()
    if opt.wrap:get() == false then
        opt.wrap = true
        require("notify")("line wrapping is on")
    else
        opt.wrap = false
        require("notify")("line wrapping is off")
    end
end

return M
