local cmd = vim.cmd
local api = vim.api
local opt = vim.opt

local m = {}

m.general = {
    i = {
        ["jk"] = { "<esc>", "escape sequence" },
        ["kj"] = { "<esc>", "escape sequence" },

        -- go to  beginning and end
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
        ["<space>w"] = { "<cmd> w <CR>", "save" },
        ["<space>q"] = { "<cmd> wq <CR>", "save and quit" },
        ["<space>Q"] = { "<cmd> q! <CR>", "force quit" },
        ["<space>c"] = { "<cmd> bd <CR>", "close buffer" },

        ["<space><space>"] = {
            function()
                require("body.part-hardline").toggle()
            end,
            "toggle status line",
        },

        -- switch between windows
        ["<c-h>"] = { "<c-w>h", "window left" },
        ["<c-l>"] = { "<c-w>l", "window right" },
        ["<c-j>"] = { "<c-w>j", "window down" },
        ["<c-k>"] = { "<c-w>k", "window up" },

        -- search highlights
        ["n"] = { "n<cmd> set hlsearch <cr>", "next search result" },
        ["N"] = { "N<cmd> set hlsearch <cr>", "previous search result" },

        -- add line
        ["[<space>"] = {
            function()
                local cursor_pos = api.nvim_win_get_cursor(0)
                cmd.normal("O")
                api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
            end,
            "prepend line",
        },
        ["]<space>"] = {
            function()
                local cursor_pos = api.nvim_win_get_cursor(0)
                cmd.normal("o")
                api.nvim_win_set_cursor(0, cursor_pos)
            end,
            "append line",
        },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
        ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

        -- new buffer
        ["<tab>"] = { "<cmd> bnext <cr>", "next buffer" },
        ["<s-tab>"] = { "<cmd> bprevious <cr>", "previous buffer" },

        -- scroll mode
        ["<space>oy"] = {
            function()
                if opt.scrolloff:get() ~= 9999 then
                    opt.scrolloff = 9999
                    require("notify")("scroll mode is on")
                else
                    opt.scrolloff = 4
                    require("notify")("scroll mode is off")
                end
            end,
            "toggle scroll mode",
        },

        ["<space>on"] = {
            function()
                if vim.opt.number:get() == false then
                    cmd.set("nu rnu")
                    require("notify")("line numbers are on")
                else
                    cmd.set("nonu nornu")
                    require("notify")("line numbers are off")
                end
            end,
            "toggle line numbers",
        },

        ["<space>ow"] = {
            function()
                if vim.opt.wrap:get() == false then
                    opt.wrap = true
                    require("notify")("line wrapping is on")
                else
                    opt.wrap = false
                    require("notify")("line wrapping is off")
                end
            end,
            "toggle line wrapping",
        },

        ["<space>ol"] = { "<cmd> LspStart <cr>", "start lsp" },
        ["<space>oL"] = { "<cmd> LspStop <cr>", "stop lsp" },
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

-- m.neotree = {
--     pkg = true,
--     n = {
--         ["<space>e"] = { "<cmd> Neotree action=focus toggle=true <cr>", "toggle file explorer" },
--         ["<leader>e"] = { "<cmd> Neotree action=focus <cr>", "toggle file explorer" },
--     },
-- }

m.chadtree = {
    pkg = true,
    n = {
        ["<space>e"] = { "<cmd> CHADopen <cr>", "toggle file explorer" },
        -- ["<leader>e"] = { "<cmd> Neotree action=focus <cr>", "toggle file explorer" },
    },
}

m.sidebar = {
    pkg = true,
    n = {
        ["<space>t"] = { "<cmd> SidebarNvimToggle <cr> <cmd> SidebarNvimFocus <cr>", "open sidebar" },
        ["<leader>t"] = { "<cmd> SidebarNvimFocus <cr>", "focus sidebar" },
    },
}

m.leap_ast = {
    pkg = true,
    n = {
        ["<space>p"] = {
            function()
                require("leap-ast").leap()
            end,
            "leap to node",
        },
    },
    x = {
        ["<space>p"] = {
            function()
                require("leap-ast").leap()
            end,
            "leap to node",
        },
    },
    o = {
        ["<space>p"] = {
            function()
                require("leap-ast").leap()
            end,
            "leap to node",
        },
    },
}

m.comment = {
    pkg = true,

    -- toggle comment in both modes
    n = {
        ["<space>/"] = {
            function()
                require("Comment.api").toggle.linewise.current()
            end,
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

-- m.coq = {
--     pkg = true,
--     i = {
--         ["<Esc>"] = { 'pumvisible() ? "<c-e><Esc>" : "<Esc>" <cr>', "" },
--         ["<a-c>"] = { '<cmd> echo pumvisible() ? "<c-e><c-c>" : "<c-c>" <cr>', "" },
--         ["<BS>"] = { '<cmd> echo pumvisible() ? "<c-e><BS>"  : "<BS>" <cr>', "" },
--         ["<CR>"] = {
--             '<cmd> echo pumvisible() ? (complete_info().selected == -1 ? "<c-n><c-y>" : "<c-y>") : "<CR>" <cr>',
--             "",
--         },
--         ["<Tab>"] = { '<cmd> echo pumvisible() ? "<c-n>" : "<Tab>" <cr>', "" },
--         ["<S-Tab>"] = { '<cmd> echo pumvisible() ? "<c-p>" : "<BS>" <cr>', "" },
--     },
-- }

m.lspconfig = {
    pkg = true,

    n = {
        ["gD"] = {
            function()
                vim.lsp.buf.declaration()
            end,
            "lsp declaration",
        },

        ["<space>k"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "lsp hover",
        },

        ["<space>d"] = {
            function()
                vim.diagnostic.open_float()
            end,
            "floating diagnostic",
        },

        ["<c-n>"] = {
            function()
                vim.diagnostic.goto_next()
            end,
            "goto_next",
        },

        ["<c-p>"] = {
            function()
                vim.diagnostic.goto_prev()
            end,
            "goto prev",
        },

        ["<space>ls"] = {
            function()
                vim.lsp.buf.signature_help()
            end,
            "lsp signature_help",
        },

        ["<space>lr"] = {
            function()
                vim.lsp.buf.rename()
            end,
            "lsp rename",
        },

        ["<leader>lc"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "lsp code_action",
        },

        ["<space>lq"] = {
            function()
                vim.diagnostic.setloclist()
            end,
            "diagnostic setloclist",
        },

        ["<space>lf"] = {
            function()
                vim.lsp.buf.format({ async = true })
            end,
            "lsp formatting",
        },

        ["<space>lwa"] = {
            function()
                vim.lsp.buf.add_workspace_folder()
            end,
            "add workspace folder",
        },

        ["<space>lwr"] = {
            function()
                vim.lsp.buf.remove_workspace_folder()
            end,
            "remove workspace folder",
        },

        ["<space>lwl"] = {
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "list workspace folders",
        },

        ["gd"] = {
            function()
                require("telescope.builtin").lsp_definitions()
            end,
            "lsp definition",
        },
        ["gi"] = {
            function()
                require("telescope.builtin").lsp_implementations()
            end,
            "lsp implementation",
        },
        ["gr"] = {
            function()
                require("telescope.builtin").lsp_references()
            end,
            "lsp references",
        },
        ["gt"] = {
            function()
                require("telescope.builtin").lsp_type_definitions()
            end,
            "lsp definition type",
        },
        ["<space>sd"] = {
            function()
                require("telescope.builtin").diagnostics()
            end,
            "search lsp diagnostics",
        },
        ["<space>ss"] = {
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            "search lsp document symbols",
        },
        ["<space>sw"] = {
            function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols()
            end,
            "search lsp workspace symbols",
        },
        ["<space>si"] = {
            function()
                require("telescope.builtin").lsp_incoming_calls()
            end,
            "search lsp incoming calls",
        },
        ["<space>so"] = {
            function()
                require("telescope.builtin").lsp_outgoing_calls()
            end,
            "search lsp outgoing calls",
        },
    },
}

local autoformatting_status = false
m.formatter = {
    pkg = true,
    n = {
        ["<space>of"] = {
            function()
                if autoformatting_status == false then
                    autoformatting_status = true
                    cmd([[
                    augroup FormatAutogroup
                        autocmd!
                        autocmd BufWritePost * FormatWrite
                    augroup END
                    ]])
                    require("notify")("autoformatting is on")
                else
                    autoformatting_status = false
                    cmd("autocmd! FormatAutogroup")
                    require("notify")("autoformatting is off")
                end
            end,
            "toggle autoformatting",
        },
    },
}

m.telescope = {
    pkg = true,

    n = {
        -- find
        ["<space>f"] = {
            function()
                require("telescope.builtin").find_files()
            end,
            "search files",
        },
        ["<space>g"] = {
            function()
                require("telescope.builtin").live_grep()
            end,
            "live grep",
        },
        ["<space>b"] = {
            function()
                require("telescope.builtin").buffers()
            end,
            "search buffers",
        },
        ["<space>n"] = {
            function()
                require("telescope.builtin").current_buffer_fuzzy_find()
            end,
            "search current buffer content",
        },
        ["<space>st"] = {
            function()
                require("telescope.builtin").treesitter()
            end,
            "search treesitter",
        },
        ["<space>sh"] = {
            function()
                require("telescope.builtin").help_tags()
            end,
            "search page",
        },
        ["<space>sr"] = {
            function()
                require("telescope.builtin").oldfiles()
            end,
            "search oldfiles",
        },
        ["<space>s;"] = {
            function()
                require("telescope.builtin").commands()
            end,
            "search commands",
        },

        -- -- git
        -- ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
        -- ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

        -- -- pick a hidden term
        -- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

        -- -- theme switcher
        -- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
    },
}

m.zenmode = {
    pkg = true,
    n = {
        ["<space>oz"] = {
            function()
                cmd("ZenMode")
            end,
            "toggle zen mode",
        },
    },
}

m.zk = {
    pkg = true,
    n = {
        ["<space>zn"] = { "<cmd> ZkNew { title = vim.fn.input('Title: ') } <cr>", "new note" },
        ["<space>zo"] = { "<cmd> ZkNotes { sort = { 'modified' } }<cr>", "open note" },
        ["<space>zt"] = { "<cmd> ZkTags <cr>", "open note by tag" },
        ["<space>zf"] = {
            "<cmd> ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') } <cr>",
            "search notes by query",
        },
    },
    v = {

        ["<space>zf"] = { "<cmd> '<,'>ZkMatch <cr>", "search notes by selection" },
    },
}

m.gitsigns = {
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

return m
