local M = {}

local utils = require 'core.utils'

M.neotree = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    require('neo-tree').setup()
end

M.colorizer = function()
    local present, colorizer = pcall(require, 'colorizer')

    if not present then return end

    local options = {
        filetypes = {
            '*',
        },
        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            -- mode = 'virtualtext', -- Set the display mode.
        },
    }

    colorizer.setup(options)
    -- execute colorizer as soon as possible
    vim.defer_fn(function() require('colorizer').attach_to_buffer(0) end, 0)
end

M.comment = function()
    local present, nvim_comment = pcall(require, 'Comment')

    if not present then return end

    local options = {
        mappings = { basic = false, extra = false },
    }
    nvim_comment.setup(options)
end

M.luasnip = function()
    local present, luasnip = pcall(require, 'luasnip')

    if not present then return end

    local options = {
        history = true,
        updateevents = 'TextChanged,TextChangedI',
    }

    luasnip.config.set_config(options)
    require('luasnip.loaders.from_vscode').lazy_load { paths = vim.g.luasnippets_path or '' }
    require('luasnip.loaders.from_vscode').lazy_load()

    vim.api.nvim_create_autocmd('InsertLeave', {
        callback = function()
            if
                require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require('luasnip').session.jump_active
            then
                require('luasnip').unlink_current()
            end
        end,
    })
end

M.gitsigns = function()
    local present, gitsigns = pcall(require, 'gitsigns')

    if present then gitsigns.setup() end
end

M.devicons = function()
    local present, devicons = pcall(require, 'nvim-web-devicons')

    if present then devicons.setup() end
end

M.packer_init = function()
    return {
        auto_clean = true,
        compile_on_sync = true,
        git = { clone_timeout = 6000 },
        display = {
            working_sym = 'ﲊ',
            error_sym = '✗ ',
            done_sym = ' ',
            removed_sym = ' ',
            moved_sym = '',
            open_fn = function() return require('packer.util').float { border = 'single' } end,
        },
    }
end

return M
