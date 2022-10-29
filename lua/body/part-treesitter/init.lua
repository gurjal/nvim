local m = {}

local options = {
    ensure_installed = { "c", "rust", "lua" },
    auto_install = true,
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true },
}

m.init = function()
    require("nvim-treesitter.configs").setup(options)
end

return m
