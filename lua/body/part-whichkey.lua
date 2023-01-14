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
    -- wk.register({
    --     l = "lsp",
    --     s = "search",
    --     t = "toggle",
    -- }, { prefix = "<leader>" })
    wk.register({}, { prefix = '<leader>' })
    wk.setup(options)
end

return M
