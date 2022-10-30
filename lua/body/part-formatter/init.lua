local M = {}

M.init = function()
    require("formatter").setup({
        filetype = {
            lua = { require("body.part-formatter.lang.formatter-lua") },
            c = { require("body.part-formatter.lang.formatter-c") },
            cpp = { require("body.part-formatter.lang.formatter-c") },
            sh = { require("body.part-formatter.lang.formatter-sh") },
            ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        },
    })
end

return M
