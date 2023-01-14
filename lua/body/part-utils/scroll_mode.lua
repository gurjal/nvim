local cmd = vim.cmd
local opt = vim.opt
local buf = vim.opt_local
local M = {}

M.toggle = function()
    if buf.scrolloff:get() ~= 9999 then
        cmd.normal 'M'
        buf.scrolloff = 9999
        buf.cursorline = false
        require 'notify' 'scroll mode is on'
    else
        buf.scrolloff = opt.scrolloff:get()
        buf.cursorline = opt.cursorline:get()
        require 'notify' 'scroll mode is off'
    end
end

return M
