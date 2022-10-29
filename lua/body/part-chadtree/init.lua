local m = {}

local chadtree_settings = {
    view = { width = 30 },
    theme = { icon_colour_set = "none" },
}

m.init = function()
    vim.api.nvim_set_var("chadtree_settings", chadtree_settings)
end

return m
