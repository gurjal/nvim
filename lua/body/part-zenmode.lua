local present, zen_mode = pcall(require, 'zen-mode')

if not present then return end

zen_mode.setup {
    window = {
        backdrop = 1.0, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = vim.opt.textwidth:get(), -- width of the Zen window
        height = 0, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
            signcolumn = 'no', -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false, -- disable cursorline
            cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
        },
    },
    plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
            enabled = true,
            ruler = true, -- disables the ruler text in the cmd line area
            showcmd = true, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = true }, -- disables git signs
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
        -- vim.opt.cmdheight = 1
        require 'notify' 'you entered zen mode'
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
        -- vim.opt.cmdheight = 0
        require 'notify' 'you exited zen mode'
    end,
}
