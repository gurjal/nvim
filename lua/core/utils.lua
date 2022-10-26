local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(section, mapping_opt)
  local function set_section_map(section_values)
    if section_values.pkg then
      return
    end
    section_values.pkg = nil

    for mode, mode_values in pairs(section_values) do
      local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = merge_tb("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end

  local mappings = require "core.mappings"

  if type(section) == "string" then
    mappings[section]["pkg"] = nil
    mappings = { mappings[section] }
  end

  for _, sect in pairs(mappings) do
    set_section_map(sect)
  end
end

-- merge default/user pkg tables
M.merge_pkgs = function(pkgs)
  local final_table = {}

  for key, val in pairs(pkgs) do
    if val and type(val) == "table" then
      pkgs[key][1] = key
      final_table[#final_table + 1] = pkgs[key]
    end
  end

  return final_table
end

M.packer_sync = function(...)
  local git_exists, git = pcall(require, "nvchad.utils.git")
  local defaults_exists, defaults = pcall(require, "nvchad.utils.config")
  local packer_exists, packer = pcall(require, "packer")

  if git_exists and defaults_exists then
    local current_branch_name = git.get_current_branch_name()

    -- warn the user if we are on a snapshot branch
    if current_branch_name:match(defaults.snaps.base_snap_branch_name .. "(.+)" .. "$") then
      vim.api.nvim_echo({
        { "WARNING: You are trying to use ", "WarningMsg" },
        { "PackerSync" },
        {
          " on a NvChadSnapshot. This will cause issues if NvChad dependencies contain "
            .. "any breaking changes! Plugin updates will not be included in this "
            .. "snapshot, so they will be lost after switching between snapshots! Would "
            .. "you still like to continue? [y/N]\n",
          "WarningMsg",
        },
      }, false, {})

      local ans = vim.trim(string.lower(vim.fn.input "-> "))

      if ans ~= "y" then
        return
      end
    end
  end

  if packer_exists then
    packer.sync(...)

    local pkgs = {}
    local old_style_options = pkgs.user or pkgs.override or pkgs.remove
    if old_style_options then
      vim.notify_once("NvChad: This plugin syntax is deprecated, use new style config.", "Error")
    end
  else
    error "Packer could not be loaded!"
  end
end

return M
