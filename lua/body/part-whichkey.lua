local M = {}

local options = {
    preset = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = true,
        g = true,
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "  ", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "none", -- none/single/double/shadow
    },
    layout = {
        spacing = 6, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    triggers_blacklist = {
        i = { "j", "k" },
    },
}

M.init = function()
    local wk = require("which-key")
    wk.register({
        l = "lsp",
        s = "search",
        o = "options",
    }, { prefix = "<leader>" })
    -- wk.register({}, { prefix = "<leader>" })
    wk.setup(options)
end

return M
