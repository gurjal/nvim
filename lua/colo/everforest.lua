vim.cmd.packadd "everforest"
vim.cmd [[
    if has('termguicolors')
      set termguicolors
    endif
    set background=dark

    let g:everforest_background = 'soft'
    let g:everforest_better_performance = 1

    colorscheme everforest
]]
