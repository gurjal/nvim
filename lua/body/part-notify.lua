local M = {}

M.options = {
    render = "minimal",
    stages = "static",
}

M.init = function()
    require("notify").setup(M.options)
    vim.notify = require("notify")
end

return M
