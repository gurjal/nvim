local cmd = vim.cmd
local M = {}

M.general = {
    i = {
        ['jk'] = { '<esc>', 'escape sequence' },
    },
    n = {
        ['<leader><leader>'] = { '<cmd> wq <cr>', 'save and quit' },
        ['<leader>/'] = {
            '<cmd> Telescope current_buffer_fuzzy_find fuzzy=false <cr>',
            'local grep',
        },
        ['<leader>?'] = { '<cmd> Telescope live_grep <cr>', 'world grep' },
        ['<leader>.'] = { '<cmd> Telescope find_files <cr>', 'search files' },
        -- goto
        ['gh'] = { '0', 'left' },
        ['gj'] = { 'G', 'bottom' },
        ['gk'] = { 'gg', 'top' },
        ['gl'] = { '$', 'right' },
        -- search
        ['<leader>n'] = { '*', 'set search register' },
        ['n'] = { 'n<cmd> set hlsearch <cr>', 'next search result' },
        ['N'] = { 'N<cmd> set hlsearch <cr>', 'previous search result' },
    },
    v = {
        -- go to
        ['gh'] = { '0', 'left' },
        ['gj'] = { 'G', 'bottom' },
        ['gk'] = { 'gg', 'top' },
        ['gl'] = { '$', 'right' },
        -- search
        ['<leader>n'] = { '*<esc><cmd> set hlsearch <cr>', 'set search register' },
    },
    x = {
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ['p'] = { 'p <cmd> let @+=@0<cr> <cmd> let @"=@0 <cr>', opts = { silent = true } },
    },
}

M.search = {
    n = {
        ['<leader>sf'] = { '<cmd> Telescope find_files <cr>', 'search files' },
        ['<leader>sb'] = { '<cmd> Telescope buffers <cr>', 'search buffers' },
        ['<leader>so'] = { '<cmd> Telescope oldfiles <cr>', 'search oldfiles' },
        ['<leader>st'] = { '<cmd> Telescope treesitter <cr>', 'search treesitter' },
        ['<leader>s;'] = { '<cmd> Telescope commands <cr>', 'search commands' },
        ['<leader>sh'] = { '<cmd> Telescope help_tags <cr>', 'search help' },
    },
}

M.file = {
    n = {
        ['<leader>f.'] = { '<cmd> Telescope find_files <cr>', 'search files' },
        ['<leader>fq'] = { '<cmd> q! <cr>', 'quit' },
        ['<leader>fs'] = { '<cmd> w <cr>', 'save' },
    },
}

M.buffer = {
    n = {
        ['\\'] = { '<cmd> bnext <cr>', 'next buffer' },
        ['|'] = { '<cmd> bprev <cr>', 'previous buffer' },
        ['<a-n>'] = { '<cmd> bnext <cr>', 'next buffer' },
        ['<a-p>'] = { '<cmd> bprev <cr>', 'previous buffer' },
        ['<leader>b.'] = { '<cmd> Telescope buffers <cr>', 'search buffers' },
        ['<leader>bk'] = { '<cmd> bd <cr>', 'kill buffer' },
        ['<leader>bd'] = { '<cmd> bd <cr>', 'kill buffer' },
    },
}


M.window = {
    n = {
        ['<leader>wq'] = { '<c-w>q', 'close' },
        ['<leader>ws'] = { '<c-w>s', 'split horizontally' },
        ['<leader>wv'] = { '<c-w>v', 'split vertically' },
        ['<leader>wh'] = { '<c-w>h', 'goto window left' },
        ['<leader>wj'] = { '<c-w>j', 'goto window down' },
        ['<leader>wk'] = { '<c-w>k', 'goto window up' },
        ['<leader>wl'] = { '<c-w>l', 'goto window right' },
        ['<leader>ww'] = { '<c-w>w', 'goto next window' },
        ['<leader>wH'] = { '<c-w>H', 'move window left' },
        ['<leader>wJ'] = { '<c-w>J', 'move window down' },
        ['<leader>wK'] = { '<c-w>K', 'move window up' },
        ['<leader>wL'] = { '<c-w>L', 'move window right' },
        ['<leader>wx'] = { '<c-w>x', 'swap current with next' },
    },
}

M.lspconfig = {
    pkg = true,
    n = {
        ['<leader>c.'] = {
            '<cmd> Telescope lsp_document_symbols <cr>',
            'search lsp document symbols',
        },
        ['<c-n>'] = { function() vim.diagnostic.goto_next() end, 'goto next diagnostics' },
        ['<c-p>'] = { function() vim.diagnostic.goto_prev() end, 'goto prev diagnostics' },
        ['<leader>h'] = { function() vim.lsp.buf.hover() end, 'lsp hover' },
        ['<leader>cn'] = { function() vim.lsp.buf.rename() end, 'lsp rename' },
        ['<leader>cs'] = { function() vim.lsp.buf.signature_help() end, 'lsp signature help' },
        ['<leader>ca'] = { function() vim.lsp.buf.code_action() end, 'lsp code action' },
        ['<leader>cq'] = { function() vim.diagnostic.setloclist() end, 'diagnostic setloclist' },
        ['<leader>cpa'] = {
            function() vim.lsp.buf.add_workspace_folder() end,
            'add workspace folder',
        },
        ['<leader>cpr'] = {
            function() vim.lsp.buf.remove_workspace_folder() end,
            'remove workspace folder',
        },
        ['<leader>cpl'] = {
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            'list workspace folders',
        },
        ['<leader>ci'] = { '<cmd> Telescope lsp_incoming_calls <cr>', 'lsp incoming calls' },
        ['<leader>co'] = { '<cmd> Telescope lsp_outgoing_calls <cr>', 'lsp outgoing calls' },
        ['<leader>cli'] = { '<cmd> LspInfo <cr>', 'lsp info' },
        -- search
        ['<leader>scd'] = { '<cmd> Telescope diagnostics <cr>', 'search lsp diagnostics' },
        ['<leader>scs'] = {
            '<cmd> Telescope lsp_document_symbols <cr>',
            'search lsp document symbols',
        },
        ['<leader>scw'] = {
            '<cmd> Telescope lsp_dynamic_workspace_symbols <cr>',
            'search lsp workspace symbols',
        },
        -- goto
        ['gcd'] = { '<cmd> Telescope lsp_definitions <cr>', 'go to definition' },
        ['gcD'] = { function() vim.lsp.buf.declaration() end, 'go to declaration' },
        ['gci'] = { '<cmd> Telescope lsp_implementations <cr>', 'go to implementation' },
        ['gct'] = { '<cmd> Telescope lsp_type_definitions <cr>', 'go to type definition' },
        ['gcr'] = { '<cmd> Telescope lsp_references <cr>', 'go to references' },
    },
}

M.mode = {
    n = {
        ['<leader>v'] = {
            function() require('body.part-utils.scroll_mode').toggle() end,
            'toggle scroll mode',
        },
        ['<leader>mk'] = {
            function() require('body.part-whichkey').init() end,
            'start which key',
        },
        -- ['<leader>mb'] = {
        --     function() require('body.part-utils.cmdheight').toggle() end,
        --     'toggle cmdheight',
        -- },
        ['<leader>mv'] = {
            function() require('body.part-utils.scroll_mode').toggle() end,
            'toggle scroll mode',
        },
        ['<leader>mn'] = {
            function() require('body.part-utils.line_numbers').toggle() end,
            'toggle line numbers',
        },
        ['<leader>ma'] = {
            function() require('body.part-utils.line_wrap').toggle() end,
            'toggle line wrapping',
        },
        ['<leader>ms'] = {
            function() require('body.part-utils.spell_check').toggle() end,
            'toggle spell check',
        },
        ['<leader>mo'] = {
            function() require('body.part-utils.note_mode').toggle() end,
            'toggle note mode',
        },
        ['<leader>mls'] = { '<cmd> LspStart <cr>', 'start lsp' },
        ['<leader>mlq'] = { '<cmd> LspStop <cr>', 'stop lsp' },
    },
}

M.zenmode = {
    pkg = true,
    n = {
        ['<leader>mz'] = { function() cmd 'ZenMode' end, 'toggle zen mode' },
    },
}

M.formatter = {
    pkg = true,
    n = {
        ['<leader>mf'] = {
            function() require('body.part-utils.autoformat').toggle() end,
            'toggle autoformatting',
        },
    },
    v = { ['<leader>mf'] = { "<cmd> '<,'>Format <cr>", 'format selection' } },
}

M.comment = {
    pkg = true,
    n = {
        ['<leader>cc'] = {
            function() require('Comment.api').toggle.linewise.current() end,
            'toggle comment',
        },
    },
    v = {
        ['<leader>cc'] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            'toggle comment',
        },
    },
}

M.leap = {
    pkg = true,
    n = {
        ['s'] = {
            function() require('leap').leap { target_windows = { vim.fn.win_getid() } } end,
            'buffer leap',
        },
        ['S'] = {
            function()
                require('leap').leap {
                    target_windows = vim.tbl_filter(
                        function(win) return vim.api.nvim_win_get_config(win).focusable end,
                        vim.api.nvim_tabpage_list_wins(0)
                    ),
                }
            end,
            'window leap',
        },
    },
    v = {
        ['s'] = {
            function() require('leap').leap { target_windows = { vim.fn.win_getid() } } end,
            'buffer leap',
        },
    },
}

M.vim_easy_align = {
    pkg = true,
    x = { ['ga'] = { '<Plug>(EasyAlign)', 'align selection to char' } },
    n = { ['ga'] = { '<Plug>(EasyAlign)', 'align selection to char' } },
}

return M
