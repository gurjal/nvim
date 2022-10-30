local cmd = vim.cmd
local opt = vim.opt
local M = {}

M.toggle = function()
    if opt.number:get() == false then
        cmd.set("nu rnu")
        require("notify")("line numbers are on")
    else
        cmd.set("nonu nornu")
        require("notify")("line numbers are off")
    end
end

return M
