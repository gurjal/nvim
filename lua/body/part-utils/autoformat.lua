local cmd = vim.cmd
local M = {}

local status = false

M.toggle = function()
    if status == false then
        status = true
        cmd([[
            augroup FormatAutogroup
                autocmd!
                autocmd BufWritePost * FormatWrite
            augroup END]])
        require("notify")("autoformatting is on")
    else
        status = false
        cmd("autocmd! FormatAutogroup")
        require("notify")("autoformatting is off")
    end
end

return M
