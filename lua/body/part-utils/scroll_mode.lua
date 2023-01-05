local cmd = vim.cmd
local opt = vim.opt
local M = {}

local user_scrolloff = nil
local user_cursorline = nil

local init = function()
    user_scrolloff = opt.scrolloff:get()
    user_cursorline = opt.cursorline:get()
end

M.toggle = function()
    if user_scrolloff == nil then init() end
    if opt.scrolloff:get() ~= user_scrolloff then
        opt.scrolloff = user_scrolloff
        opt.cursorline = user_cursorline
        require 'notify' 'scroll mode is off'
    else
        cmd.normal 'M'
        opt.scrolloff = 9999
        opt.cursorline = false
        require 'notify' 'scroll mode is on'
    end
end

return M
