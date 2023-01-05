local opt = vim.opt
local util = require 'formatter.util'

return function()
    return {
        exe = 'stylua',
        args = {
            '--call-parentheses',
            'None',
            '--quote-style',
            'AutoPreferSingle',
            '--collapse-simple-statement',
            'Always',
            '--indent-type',
            'Spaces',
            '--column-width',
            opt.textwidth:get(),
            '--indent-width',
            opt.tabstop:get(),
            '--search-parent-directories',
            '--stdin-filepath',
            util.escape_path(util.get_current_buffer_file_path()),
            '--',
            '-',
        },
        stdin = true,
    }
end
