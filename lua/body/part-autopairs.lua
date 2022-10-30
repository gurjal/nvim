local M = {}

local options = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
}

M.init = function()
    require("nvim-autopairs").setup(options)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
