vim.defer_fn(function() pcall(require, "impatient") end, 0)

require("core")
require("core.options")

-- setup packer + plugins
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#111111" })
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
    require("pkgs")
    vim.cmd("PackerSync")
end

require("core.utils").load_mappings()
require("colo.tundra")
