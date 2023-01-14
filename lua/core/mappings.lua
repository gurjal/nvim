local cmd = vim.cmd
local M = {}

M.general = {
    i = {
        ['jk'] = { '<esc>', 'escape sequence' },

        -- -- go to beginning and end
        -- ['<c-b>'] = { '<ESC>^i', 'beginning of line' },
        -- ['<c-e>'] = { '<End>', 'end of line' },

        -- -- navigate within insert mode
        -- ['<c-h>'] = { '<Left>', 'move left' },
        -- ['<c-l>'] = { '<Right>', 'move right' },
        -- ['<c-j>'] = { '<Down>', 'move down' },
        -- ['<c-k>'] = { '<Up>', 'move up' },
    },

    n = {
        -- go to beginning and end
        ['gh'] = { '0', 'beginning of line' },
        ['gl'] = { '$', 'end of line' },

        -- save
        ['<leader>w'] = { '<cmd> w <cr>', 'save buffer' },
        ['<leader>d'] = { '<cmd> bd <cr>', 'delete buffer' },
        ['<leader>q'] = { '<cmd> q! <cr>', 'force quit' },
        ['<leader><leader>'] = { '<cmd> wq <cr>', 'save and quit' },

        -- buffers
        ['\\'] = { '<cmd> bnext <cr>', 'next buffer' },
        ['|'] =  { '<cmd> bprev <cr>', 'previous buffer' },

        -- tabs
        ['<a-f>'] = { '<cmd> tabnext <cr>', 'next tab' },
        ['<a-b>'] = { '<cmd> tabprevious <cr>', 'previous tab' },

        -- windows
        ['<c-h>'] = { '<c-w>h', 'window left' },
        ['<c-l>'] = { '<c-w>l', 'window right' },
        ['<c-j>'] = { '<c-w>j', 'window down' },
        ['<c-k>'] = { '<c-w>k', 'window up' },

        -- search highlights
        ['n'] = { 'n<cmd> set hlsearch <cr>', 'next search result' },
        ['N'] = { 'N<cmd> set hlsearch <cr>', 'previous search result' },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

        -- -- append line
        -- ["]<leader>"] = {
        --     function()
        --         local cursor_pos = api.nvim_win_get_cursor(0)
        --         cmd.normal("o")
        --         api.nvim_win_set_cursor(0, cursor_pos)
        --     end,
        --     "append line",
        -- },

        -- -- prepend line
        -- ["[<leader>"] = {
        --     function()
        --         local cursor_pos = api.nvim_win_get_cursor(0)
        --         cmd.normal("O")
        --         api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
        --     end,
        --     "prepend line",
        -- },

        ['<leader>uk'] = {
            function() require('body.part-whichkey').init() end,
            'start which key',
        },

        -- ['<leader>uB'] = {
        --     function() require('body.part-utils.hardline').toggle() end,
        --     'toggle status line',
        -- },

        ['<leader>ub'] = {
            function() require('body.part-utils.cmdheight').toggle() end,
            'toggle cmdheight',
        },

        ['<leader>uy'] = {
            function() require('body.part-utils.scroll_mode').toggle() end,
            'toggle scroll mode',
        },

        ['<leader>un'] = {
            function() require('body.part-utils.line_numbers').toggle() end,
            'toggle line numbers',
        },

        ['<leader>ua'] = {
            function() require('body.part-utils.line_wrap').toggle() end,
            'toggle line wrapping',
        },

        ['<leader>us'] = {
            function() require('body.part-utils.spell_check').toggle() end,
            'toggle spell check',
        },

        ['<leader>uo'] = {
            function() require('body.part-utils.note_mode').toggle() end,
            'toggle note mode',
        },

        ['<leader>ul'] = { '<cmd> LspStart <cr>', 'start lsp' },
        ['<leader>uL'] = { '<cmd> LspStop <cr>', 'stop lsp' },
    },

    v = {
        ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    },

    x = {
        ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ['p'] = { 'p <cmd> let @+=@0<cr> <cmd> let @"=@0 <cr>', opts = { silent = true } },
    },
}

M.neotree = {
    pkg = true,
    n = {
        ['<leader>e'] = { '<cmd> Neotree action=focus toggle=true <cr>', 'toggle file explorer' },
    },
}

-- M.comment = {
--     pkg = true,
--     n = {
--         ["<leader>cc"] = {
--             function() require("Comment.api").toggle.linewise.current() end,
--             "toggle comment",
--         },
--         ["<leader>c"] = {
--             function() require("Comment.api").toggle.linewise.current() end,
--             " comment",
--         },
--     },
--     v = {
--         ["<leader>c"] = {
--             "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
--             "toggle comment",
--         },
--     },
-- }

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
}

M.lspconfig = {
    pkg = true,
    n = {
        ['K'] = { function() vim.lsp.buf.hover() end, 'lsp hover' },
        ['<c-n>'] = { function() vim.diagnostic.goto_next() end, 'goto next diagnostics' },
        ['<c-p>'] = { function() vim.diagnostic.goto_prev() end, 'goto prev diagnostics' },
        ['gD'] = { function() vim.lsp.buf.declaration() end, 'lsp declaration' },
        ['<leader>r'] = { function() vim.lsp.buf.rename() end, 'lsp rename' },
        ['<leader>ls'] = { function() vim.lsp.buf.signature_help() end, 'lsp signature help' },
        ['<leader>lc'] = { function() vim.lsp.buf.code_action() end, 'lsp code action' },
        ['<leader>lq'] = { function() vim.diagnostic.setloclist() end, 'diagnostic setloclist' },
        ['<leader>lwa'] = {
            function() vim.lsp.buf.add_workspace_folder() end,
            'add workspace folder',
        },
        ['<leader>lwr'] = {
            function() vim.lsp.buf.remove_workspace_folder() end,
            'remove workspace folder',
        },
        ['<leader>lwl'] = {
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            'list workspace folders',
        },
        ['gd'] = { '<cmd> Telescope lsp_definitions <cr>', 'lsp definition' },
        ['gi'] = { '<cmd> Telescope lsp_implementations <cr>', 'lsp implementation' },
        ['gt'] = { '<cmd> Telescope lsp_type_definitions <cr>', 'lsp definition type' },
        ['<leader>k'] = {
            '<cmd> Telescope lsp_document_symbols <cr>',
            'search lsp document symbols',
        },
        ['<leader>K'] = {
            '<cmd> Telescope lsp_dynamic_workspace_symbols <cr>',
            'search lsp workspace symbols',
        },
        ['<leader>sd'] = { '<cmd> Telescope diagnostics <cr>', 'search lsp diagnostics' },
        ['<leader>lr'] = { '<cmd> Telescope lsp_references <cr>', 'lsp references' },
        ['<leader>li'] = { '<cmd> Telescope lsp_incoming_calls <cr>', 'search lsp incoming calls' },
        ['<leader>lo'] = { '<cmd> Telescope lsp_outgoing_calls <cr>', 'search lsp outgoing calls' },
    },
}

M.formatter = {
    pkg = true,
    n = {
        ['<leader>uF'] = { '<cmd> Format <cr>', 'format document' },
        ['<leader>uf'] = {
            function() require('body.part-utils.autoformat').toggle() end,
            'toggle autoformatting',
        },
    },
    v = { ['<leader>uf'] = { "<cmd> '<,'>Format <cr>", 'format selection' } },
}

M.vim_easy_align = {
    pkg = true,
    x = { ['ga'] = { '<Plug>(EasyAlign)', 'align selection to char' } },
    n = { ['ga'] = { '<Plug>(EasyAlign)', 'align selection to char' } },
}

M.telescope = {
    pkg = true,
    n = {
        ['<leader>f'] = { '<cmd> Telescope find_files <cr>', 'search files' },
        ['<leader>g'] = { '<cmd> Telescope live_grep <cr>', 'world grep' },
        ['<leader>/'] = {
            '<cmd> Telescope current_buffer_fuzzy_find fuzzy=false <cr>',
            'local grep',
        },
        ['<leader>b'] = { '<cmd> Telescope buffers <cr>', 'search buffers' },
        ['<leader>k'] = { '<cmd> Telescope treesitter <cr>', 'search treesitter' },
        ['<leader>sr'] = { '<cmd> Telescope oldfiles <cr>', 'search oldfiles' },
        ['<leader>s;'] = { '<cmd> Telescope commands <cr>', 'search commands' },
        ['<leader>sh'] = { '<cmd> Telescope help_tags <cr>', 'search page' },
    },
}

M.zenmode = {
    pkg = true,
    n = {
        ['<leader>uz'] = { function() cmd 'ZenMode' end, 'toggle zen mode' },
    },
}

M.gitsigns = {
    pkg = true,

    -- n = {
    --     -- Navigation through hunks
    --     ["]c"] = {
    --         function()
    --             if vim.wo.diff then
    --                 return "]c"
    --             end
    --             vim.schedule(function()
    --                 require("gitsigns").next_hunk()
    --             end)
    --             return "<Ignore>"
    --         end,
    --         "Jump to next hunk",
    --         opts = { expr = true },
    --     },
    --
    --     ["[c"] = {
    --         function()
    --             if vim.wo.diff then
    --                 return "[c"
    --             end
    --             vim.schedule(function()
    --                 require("gitsigns").prev_hunk()
    --             end)
    --             return "<Ignore>"
    --         end,
    --         "Jump to prev hunk",
    --         opts = { expr = true },
    --     },
    --
    --     -- Actions
    --     ["<leader>rh"] = {
    --         function()
    --             require("gitsigns").reset_hunk()
    --         end,
    --         "Reset hunk",
    --     },
    --
    --     ["<leader>ph"] = {
    --         function()
    --             require("gitsigns").preview_hunk()
    --         end,
    --         "Preview hunk",
    --     },
    --
    --     ["<leader>gb"] = {
    --         function()
    --             package.loaded.gitsigns.blame_line()
    --         end,
    --         "Blame line",
    --     },
    --
    --     ["<leader>td"] = {
    --         function()
    --             require("gitsigns").toggle_deleted()
    --         end,
    --         "Toggle deleted",
    --     },
    -- },
}

return M
