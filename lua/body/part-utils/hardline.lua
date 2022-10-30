local opt = vim.opt
local M = {}

local alive = false

local status = false

M.toggle = function()
    if status == false then
        if not alive then
            require("body.part-hardline").init()
            alive = true
        end
        opt.laststatus = 3
        status = true
    else
        opt.laststatus = 0
        status = false
    end
end

return M
