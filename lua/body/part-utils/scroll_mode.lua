local cmd = vim.cmd
local opt = vim.opt
local buf = vim.opt_local
local M = {}

local userscrolloff = nil
local usercursorline = nil

M.toggle = function()
    if buf.scrolloff:get() ~= 9999 then
        userscrolloff = opt.scrolloff:get()
        usercursorline = opt.cursorline:get()
        cmd.normal 'M'
        buf.scrolloff = 9999
        buf.cursorline = false
        require 'notify' 'scroll mode is on'
    else
        buf.scrolloff = userscrolloff
        buf.cursorline = usercursorline
        require 'notify' 'scroll mode is off'
    end
end

return M
