local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- macro recording notifications
local aug_recording = augroup("recording", { clear = true })
autocmd("RecordingEnter", { group = aug_recording, callback = function() require("notify")("recording...") end })
autocmd("RecordingLeave", { group = aug_recording, callback = function() require("notify")("done") end })

-- dont list quickfix buffers
autocmd("FileType", { pattern = "qf", callback = function() vim.opt_local.buflisted = false end })

-- disabe search highlights on cursor move
local aug_autohlsearch = augroup("autohlsearch", { clear = true })
autocmd("CmdlineEnter", { group = aug_autohlsearch, pattern = { "/", "?" }, command = "set hlsearch" })
autocmd("CursorMoved", { group = aug_autohlsearch, pattern = "*", command = "set nohlsearch" })

-- set zsh filetype to bash
autocmd("FileType", { pattern = "zsh", callback = function() vim.bo.filetype = "bash" end })
