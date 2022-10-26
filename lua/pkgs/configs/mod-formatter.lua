local util = require "formatter.util"

require("formatter").setup {
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        vim.opt.tabstop:get(),
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        sh = {
            function()
                return {
                    exe = "shfmt",
                    args = {
                        "-i",
                        vim.opt.tabstop:get(),
                    },
                    stdin = true,
                }
            end,
        },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
}
