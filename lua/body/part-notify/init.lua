local m = {}

m.options = {
    render = "minimal",
    stages = "static",
}

m.setup = function()
    require("notify").setup(m.options)
    vim.notify = require("notify")
end

return m
