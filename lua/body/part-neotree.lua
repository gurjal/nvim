local M = {}

local options = {
    window = {
        width = 30,
    },
    filesystem = {
        follow_current_file = true,
    },
    buffer = {
        follow_current_file = true,
    },
}

M.init = function()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("neo-tree").setup(options)
end

return M
