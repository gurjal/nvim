local M = {}

local options = {
    plugins = {
        marks = true,
        spelling = { enabled = true },
    },
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
}

M.init = function()
    local wk = require 'which-key'
    wk.register({
        c = { name = 'code' },
        b = { name = 'buffer' },
        m = { name = 'mode' },
        w = { name = 'window' },
    }, { prefix = '<leader>' })
    wk.register({
        c = {
            name = 'code',
        },
    }, { prefix = 'g' })
    wk.setup(options)
end

return M
