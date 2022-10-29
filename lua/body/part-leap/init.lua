local leap = require("leap")

local m = {}

local options = {
    case_sensitive = false,
    highlight_unlabeled_phase_one_targets = true,
}

m.init = function()
    leap.add_default_mappings()
    leap.setup(options)
end

return m
