local util = require("formatter.util")

return function()
    return {
        exe = "stylua",
        args = {
            "--indent-type",
            "Spaces",
            "--indent-width",
            vim.opt.tabstop:get(),
            "--collapse-simple-statement",
            "Always",
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
    }
end
