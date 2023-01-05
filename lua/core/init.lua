local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- dont list quickfix buffers
autocmd('FileType', {
    pattern = 'qf',
    callback = function() vim.opt_local.buflisted = false end,
})

-- disable search highlights on cursor move
local aug_autohlsearch = augroup('autohlsearch', { clear = true })
autocmd('CmdlineEnter', {
    group = aug_autohlsearch,
    pattern = { '/', '?' },
    command = 'set hlsearch',
})
autocmd('CursorMoved', {
    group = aug_autohlsearch,
    pattern = '*',
    command = 'set nohlsearch',
})

-- notifications for recording macro
local aug_recording = augroup('recording', { clear = true })
autocmd('RecordingEnter', {
    group = aug_recording,
    callback = function() require 'notify' 'recording...' end,
})
autocmd('RecordingLeave', {
    group = aug_recording,
    callback = function() require 'notify' 'done' end,
})

-- -- set zsh filetype to bash
-- autocmd('FileType', {
--     pattern = 'zsh',
--     callback = function() vim.bo.filetype = 'bash' end,
-- })

-- setup packer + plugins
local packpath = vim.fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(packpath)) > 0 then
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#000000' })
    vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packpath,
    }
    vim.cmd.packadd 'packer.nvim'
    require 'pkgs'
    vim.cmd.PackerSync()

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PackerComplete',
        callback = function() require('packer').loader 'nvim-treesitter' end,
    })
end
