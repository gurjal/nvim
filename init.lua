vim.defer_fn(function()
    pcall(require, "impatient")
end, 0)

require("core")
require("core.options")

-- setup packer + plugins
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd("packadd packer.nvim")
    require("pkgs")
    vim.cmd("PackerSync")
end

require("core.utils").load_mappings()
require("colo.everforest")
