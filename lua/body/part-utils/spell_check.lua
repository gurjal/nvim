local opt = vim.opt
local M = {}

M.toggle = function()
    if opt.spell:get() ~= true then
        opt.spell = true
        require("notify")("spell check is on")
    else
        opt.spell = false
        require("notify")("spell check is off")
    end
end

return M
