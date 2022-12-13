local cmd = vim.cmd
local api = vim.api
local M = {}

M.general = {
    i = {
        ["jk"] = { "<esc>", "escape sequence" },
        ["kj"] = { "<esc>", "escape sequence" },

        -- go to beginning and end
        ["<c-b>"] = { "<ESC>^i", "beginning of line" },
        ["<c-e>"] = { "<End>", "end of line" },

        -- navigate within insert mode
        ["<c-h>"] = { "<Left>", "move left" },
        ["<c-l>"] = { "<Right>", "move right" },
        ["<c-j>"] = { "<Down>", "move down" },
        ["<c-k>"] = { "<Up>", "move up" },
    },

    n = {
        -- save
        ["<space>j"] = { "<cmd> w <cr>", "save buffer" },
        ["<space>k"] = { "<cmd> bd <cr>", "kill buffer" },
        ["<space>q"] = { "<cmd> q! <cr>", "force quit" },
        ["<space><space>"] = { "<cmd> wq <cr>", "save and quit" },

        -- switch between windows
        ["<space>n"] = { "<c-w>w", "next window" },
        ["<space>p"] = { "<c-w>W", "previous window" },
        ["<c-l>"] = { "<c-w>w", "next window" },
        ["<c-h>"] = { "<c-w>W", "previous window" },

        -- line motion
        ["gh"] = { "0", "goto beginning of line" },
        ["gl"] = { "$", "goto end of line" },
        ["<leader><leader>"] = { "<cmd> normal zz <cr>", "center line" },


        -- search highlights
        ["n"] = { "n<cmd> set hlsearch <cr>", "next search result" },
        ["N"] = { "N<cmd> set hlsearch <cr>", "previous search result" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

        -- new buffer
        ["\\"] = { "<cmd> bnext <cr>", "next buffer" },
        ["|"] = { "<cmd> bprev <cr>", "previous buffer" },
        ["<c-j>"] = { "<cmd> bnext <cr>", "next buffer" },
        ["<c-k>"] = { "<cmd> bprev <cr>", "previous buffer" },

        -- append line
        ["]<space>"] = {
            function()
                local cursor_pos = api.nvim_win_get_cursor(0)
                cmd.normal("o")
                api.nvim_win_set_cursor(0, cursor_pos)
            end,
            "append line",
        },

        -- prepend line
        ["[<space>"] = {
            function()
                local cursor_pos = api.nvim_win_get_cursor(0)
                cmd.normal("O")
                api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
            end,
            "prepend line",
        },

        ["<leader>k"] = {
            function() require("body.part-whichkey").init() end,
            "start which key",
        },

        ["<leader>b"] = {
            function() require("body.part-utils.hardline").toggle() end,
            "toggle status line",
        },

        ["<leader>B"] = {
            function() require("body.part-utils.cmdheight").toggle() end,
            "toggle cmdheight",
        },

        ["<leader>y"] = {
            function() require("body.part-utils.scroll_mode").toggle() end,
            "toggle scroll mode",
        },

        ["<leader>n"] = {
            function() require("body.part-utils.line_numbers").toggle() end,
            "toggle line numbers",
        },

        ["<leader>a"] = {
            function() require("body.part-utils.line_wrap").toggle() end,
            "toggle line wrapping",
        },

        ["<leader>l"] = { "<cmd> LspStart <cr>", "start lsp" },
        ["<leader>L"] = { "<cmd> LspStop <cr>", "stop lsp" },
    },

    v = {
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
    },

    x = {
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p <cmd> let @+=@0<cr> <cmd> let @"=@0 <cr>', opts = { silent = true } },
    },
}

M.neotree = {
    pkg = true,
    n = { ["<space>e"] = { "<cmd> Neotree action=focus toggle=true <cr>", "toggle file explorer" } },
}

M.leap_ast = {
    pkg = true,
    n = { ["<space>u"] = { function() require("leap-ast").leap() end, "leap to node" } },
    x = { ["<space>u"] = { function() require("leap-ast").leap() end, "leap to node" } },
    o = { ["<space>u"] = { function() require("leap-ast").leap() end, "leap to node" } },
}

M.comment = {
    pkg = true,
    n = {
        ["<space>/"] = {
            function() require("Comment.api").toggle.linewise.current() end,
            "toggle comment",
        },
    },
    v = {
        ["<space>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "toggle comment",
        },
    },
}

M.lspconfig = {
    pkg = true,
    n = {
        ["K"] = { function() vim.lsp.buf.hover() end, "lsp hover" },
        ["<c-n>"] = { function() vim.diagnostic.goto_next() end, "goto next diagnostics" },
        ["<c-p>"] = { function() vim.diagnostic.goto_prev() end, "goto prev diagnostics" },
        ["<space>d"] = { function() vim.diagnostic.open_float() end, "floating diagnostic" },
        ["gD"] = { function() vim.lsp.buf.declaration() end, "lsp declaration" },
        ["<space>r"] = { function() vim.lsp.buf.rename() end, "lsp rename" },
        ["<space>ls"] = { function() vim.lsp.buf.signature_help() end, "lsp signature help" },
        ["<space>lc"] = { function() vim.lsp.buf.code_action() end, "lsp code action" },
        ["<space>lq"] = { function() vim.diagnostic.setloclist() end, "diagnostic setloclist" },
        ["<space>lwa"] = { function() vim.lsp.buf.add_workspace_folder() end, "add workspace folder" },
        ["<space>lwr"] = { function() vim.lsp.buf.remove_workspace_folder() end, "remove workspace folder" },
        ["<space>lwl"] = {
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
            "list workspace folders",
        },
        ["gd"] = { "<cmd> Telescope lsp_definitions <cr>", "lsp definition" },
        ["gi"] = { "<cmd> Telescope lsp_implementations <cr>", "lsp implementation" },
        ["gt"] = { "<cmd> Telescope lsp_type_definitions <cr>", "lsp definition type" },
        ["<space>w"] = { "<cmd> Telescope lsp_document_symbols <cr>", "search lsp document symbols" },
        ["<space>W"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <cr>", "search lsp workspace symbols" },
        ["<space>sd"] = { "<cmd> Telescope diagnostics <cr>", "search lsp diagnostics" },
        ["<space>lr"] = { "<cmd> Telescope lsp_references <cr>", "lsp references" },
        ["<space>li"] = { "<cmd> Telescope lsp_incoming_calls <cr>", "search lsp incoming calls" },
        ["<space>lo"] = { "<cmd> Telescope lsp_outgoing_calls <cr>", "search lsp outgoing calls" },
    },
}

M.formatter = {
    pkg = true,
    n = {
        ["<leader>F"] = { "<cmd> Format <cr>", "format document" },
        ["<leader>f"] = {
            function() require("body.part-utils.autoformat").toggle() end,
            "toggle autoformatting",
        },
    },
    v = {
        ["<leader>f"] = { "<cmd> '<,'>Format <cr>", "format selection" },
    },
}

M.vim_easy_align = {
    pkg = true,
    x = {
        ["ga"] = { "<Plug>(EasyAlign)", "align selection to char" },
    },
    n = {
        ["ga"] = { "<Plug>(EasyAlign)", "align selection to char" },
    },
}

M.telescope = {
    pkg = true,
    n = {
        ["<space>f"] = { "<cmd> Telescope find_files <cr>", "search files" },
        ["<space>g"] = { "<cmd> Telescope live_grep <cr>", "live grep" },
        ["<space>b"] = { "<cmd> Telescope buffers <cr>", "search buffers" },
        ["<space>w"] = { "<cmd> Telescope treesitter <cr>", "search treesitter" },
        ["<space>sh"] = { "<cmd> Telescope help_tags <cr>", "search page" },
        ["<space>sr"] = { "<cmd> Telescope oldfiles <cr>", "search oldfiles" },
        ["<space>s;"] = { "<cmd> Telescope commands <cr>", "search commands" },
    },
}

M.zenmode = {
    pkg = true,
    n = {
        ["<leader>z"] = { function() cmd("ZenMode") end, "toggle zen mode" },
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
