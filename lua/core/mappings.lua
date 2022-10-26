local cmd = vim.cmd
local api = vim.api
local opt = vim.opt
local packadd = vim.cmd.packadd

-- n, v, i, t = mode names

local M = {}

M.general = {
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
                cmd.normal "O"
                api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
            end,
            "prepend line",
        },
        ["]<space>"] = {
            function()
                local cursor_pos = api.nvim_win_get_cursor(0)
                cmd.normal "o"
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
                    require "notify" "scroll mode is on"
                else
                    opt.scrolloff = 4
                    require "notify" "scroll mode is off"
                end
            end,
            "toggle scroll mode",
        },

        ["<space>on"] = {
            function()
                if vim.opt.number:get() == false then
                    cmd.set "nu rnu"
                    require "notify" "line numbers are on"
                else
                    cmd.set "nonu nornu"
                    require "notify" "line numbers are off"
                end
            end,
            "toggle line numbers",
        },

        ["<space>ow"] = {
            function()
                if vim.opt.wrap:get() == false then
                    opt.wrap = true
                    require "notify" "line wrapping is on"
                else
                    opt.wrap = false
                    require "notify" "line wrapping is off"
                end
            end,
            "toggle line wrapping",
        },
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
    n = {
        ["<space>e"] = { "<cmd> Neotree action=focus toggle=true <cr>", "toggle file explorer" },
    },
}

M.comment = {
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

M.lspconfig = {
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
                vim.lsp.buf.format { async = true }
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

        ["gd"] = { "<cmd> Telescope lsp_definitions <cr>", "lsp definition" },
        ["gi"] = { "<cmd> Telescope lsp_implementations <cr>", "lsp implementation" },
        ["gr"] = { "<cmd> Telescope lsp_references <cr>", "lsp references" },
        ["gt"] = { "<cmd> Telescope lsp_type_definitions <cr>", "lsp definition type" },
        ["<space>sd"] = { "<cmd> Telescope diagnostics <cr>", "search lsp diagnostics" },
        ["<space>ss"] = { "<cmd> Telescope lsp_document_symbols <cr>", "search lsp document symbols" },
        ["<space>sw"] = { "<cmd> Telescope lsp_dynamic_workspace_symbols <cr>", "search lsp workspace symbols" },
        ["<space>si"] = { "<cmd> Telescope lsp_incoming_calls <cr>", "search lsp incoming calls" },
        ["<space>so"] = { "<cmd> Telescope lsp_outgoing_calls <cr>", "search lsp outgoing calls" },
    },
}

local autoformatting_status = false
local autoformatting_loaded = false
local load_autoformatting = function()
    if autoformatting_loaded == false then
        packadd "formatter.nvim"
        require "pkgs.configs.mod-formatter"
        autoformatting_loaded = true
    end
end
M.formatter = {
    pkg = true,
    n = {
        ["<space>of"] = {
            function()
                if autoformatting_status == false then
                    autoformatting_status = true
                    load_autoformatting()
                    cmd [[
            augroup FormatAutogroup
              autocmd!
              autocmd BufWritePost * FormatWrite
            augroup END
          ]]
                    require "notify" "autoformatting is on"
                else
                    autoformatting_status = false
                    cmd "autocmd! FormatAutogroup"
                    require "notify" "autoformatting is off"
                end
            end,
            "toggle autoformatting",
        },
    },
}

M.telescope = {
    pkg = true,

    n = {
        -- find
        ["<space>f"] = { "<cmd> Telescope find_files <cr>", "search files" },
        ["<space>g"] = { "<cmd> Telescope live_grep <cr>", "live grep" },
        ["<space>b"] = { "<cmd> Telescope buffers <cr>", "search buffers" },
        ["<space>st"] = { "<cmd> Telescope treesitter <cr>", "search treesitter" },
        ["<space>sh"] = { "<cmd> Telescope help_tags <cr>", "search page" },
        ["<space>sr"] = { "<cmd> Telescope oldfiles <cr>", "search oldfiles" },
        ["<space>s:"] = { "<cmd> Telescope oldfiles <cr>", "search commands" },

        -- -- git
        -- ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "git commits" },
        -- ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "git status" },

        -- -- pick a hidden term
        -- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },

        -- -- theme switcher
        -- ["<leader>th"] = { "<cmd> Telescope themes <CR>", "nvchad themes" },
    },
}

local zenmode_loaded = false
local load_zenmode = function()
    if zenmode_loaded == false then
        packadd "zen-mode.nvim"
        packadd "twilight.nvim"
        require "pkgs.configs.mod-zenmode"
        zenmode_loaded = true
    end
end
M.zenmode = {
    pkg = true,
    n = {
        ["<space>oz"] = {
            function()
                load_zenmode()
                cmd "ZenMode"
            end,
            "toggle zen mode",
        },
    },
}

M.zk = {
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

M.gitsigns = {
  pkg = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

return M
