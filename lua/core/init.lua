-- autocmds
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

autocmd("UIEnter", {
    callback = function()
        require("colo.everforest")
    end,
})

-- dont list quickfix buffers
autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})

-- cmd([[
--     au vimenter * hi Normal guibg=NONE ctermbg=NONE
--     au vimenter * hi EndOfBuffer guibg=NONE ctermbg=NONE
-- ]])

cmd([[
    aug vimrc-incsearch-highlight
        au!
        au CmdlineEnter /,\? set hlsearch
        au CursorMoved * set nohlsearch
    aug END
]])
