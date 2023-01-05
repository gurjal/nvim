local leap = require("leap")

local M = {}

local options = {
    case_sensitive = false,
    highlight_unlabeled_phase_one_targets = false,
}

M.init = function()
    leap.setup(options)
end

return M
