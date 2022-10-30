local leap = require("leap")

local M = {}

local options = {
    case_sensitive = false,
    highlight_unlabeled_phase_one_targets = true,
}

M.init = function()
    leap.add_default_mappings()
    leap.setup(options)
end

return M
