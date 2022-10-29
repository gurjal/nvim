local pkgs = {

    ["lewis6991/impatient.nvim"] = {},

    ["wbthomason/packer.nvim"] = {
        cmd = require("core.lazy_load").packer_cmds,
        config = function()
            require("pkgs")
        end,
    },

    ["kyazdani42/nvim-web-devicons"] = {
        module = "nvim-web-devicons",
        setup = function()
            require("core.lazy_load").on_file_open("nvim-web-devicons")
        end,
        config = function()
            require("body.part-others").devicons()
        end,
    },

    ["NvChad/nvim-colorizer.lua"] = {
        module = "colorizer",
        setup = function()
            require("core.lazy_load").on_file_open("nvim-colorizer.lua")
        end,
        config = function()
            require("body.part-others").colorizer()
        end,
    },

    ["nvim-treesitter/nvim-treesitter"] = {
        module = "nvim-treesitter",
        cmd = require("core.lazy_load").treesitter_cmds,
        run = ":TSUpdate",
        setup = function()
            require("core.lazy_load").on_file_open("nvim-treesitter")
        end,
        config = function()
            require("body.part-treesitter").init()
        end,
    },

    -- git stuff
    ["lewis6991/gitsigns.nvim"] = {
        ft = "gitcommit",
        setup = function()
            require("core.lazy_load").gitsigns()
        end,
        config = function()
            require("body.part-others").gitsigns()
        end,
    },

    -- lsp stuff
    ["neovim/nvim-lspconfig"] = {
        module = "nvim-lspconfig",
        opt = true,
        setup = function()
            require("core.lazy_load").on_file_open("nvim-lspconfig")
        end,
        config = function()
            require("body.part-lsp").init_lspconfig()
        end,
    },

    -- load luasnips + cmp related in insert mode only
    ["rafamadriz/friendly-snippets"] = { event = { "InsertEnter", "CmdlineEnter" } },
    ["hrsh7th/nvim-cmp"] = { after = "friendly-snippets" },
    ["hrsh7th/cmp-nvim-lsp"] = { after = "nvim-cmp" },
    ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
    ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },
    ["hrsh7th/cmp-cmdline"] = { after = "cmp-path" },
    ["hrsh7th/cmp-nvim-lua"] = { after = "cmp-cmdline" },
    ["L3MON4D3/LuaSnip"] = { after = "cmp-nvim-lua" },
    ["saadparwaiz1/cmp_luasnip"] = {
        after = "LuaSnip",
        config = function()
            require("body.part-others").luasnip()
            require("body.part-lsp").init_cmp()
        end,
    },

    ["rcarriga/nvim-notify"] = {
        module = "notify",
        config = function()
            require("body.part-notify").setup()
        end,
    },

    ["ms-jpq/chadtree"] = {
        cmd = "CHADopen",
        branch = "chad",
        run = "python3 -m chadtree deps",
        setup = function()
            require("core.utils").load_mappings("chadtree")
        end,
        config = function()
            require("body.part-chadtree").init()
        end,
    },

    -- formatting
    ["mhartington/formatter.nvim"] = {
        cmd = "FormatWrite",
        setup = function()
            require("core.utils").load_mappings("formatter")
        end,
        config = function()
            require("body.part-formatter").setup()
        end,
    },

    ["ojroques/nvim-hardline"] = {module = "hardline"},

    -- misc pkgs
    ["windwp/nvim-autopairs"] = {
        event = "InsertEnter",
        config = function()
            require("body.part-autopairs").init()
        end,
    },

    ["kylechui/nvim-surround"] = {
        event = "VimEnter",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    ["numToStr/Comment.nvim"] = {
        keys = { "gc", "gb" },
        config = function()
            require("body.part-others").comment()
        end,
        setup = function()
            require("core.utils").load_mappings("comment")
        end,
    },

    ["nvim-lua/plenary.nvim"] = { opt = true },

    ["nvim-telescope/telescope.nvim"] = {
        module = 'telescope',
        wants = "plenary.nvim",
        config = function()
            require("body.part-telescope")
        end,
        setup = function()
            require("core.utils").load_mappings("telescope")
        end,
    },

    -- Only load whichkey after all the gui
    ["folke/which-key.nvim"] = {
        event = "UIEnter",
        -- opt = true,
        config = function()
            require("body.part-whichkey")
        end,
    },

    ["folke/twilight.nvim"] = { module = "twilight" },

    ["folke/zen-mode.nvim"] = {
        cmd = "ZenMode",
        wants = "twilight.nvim",
        setup = function()
            require("core.utils").load_mappings("zenmode")
        end,
        config = function()
            require("body.part-zenmode")
        end,
    },

    ["tpope/vim-repeat"] = { module = "vim-repeat" },

    ["ggandor/leap.nvim"] = {
        -- module = "leap",
        wants = "vim-repeat",
        -- keys = { "s", "S", "x", "X" },
        config = function()
            require("body.part-leap").init()
        end,
    },
    ["ggandor/leap-ast.nvim"] = {
        module="leap-ast",
        wants = "leap.nvim",
        setup = function()
            require("core.utils").load_mappings("leap_ast")
        end,
    },

    ["mickael-menu/zk-nvim"] = {
        ft = { "markdown" },
        cmd = require("core.lazy_load").zk_cmds,
        setup = function()
            require("core.utils").load_mappings("zk")
        end,
        config = function()
            require("body.part-zk")
        end,
    },

    ["bluz71/vim-moonfly-colors"] = { opt = true },
    ["bluz71/vim-nightfly-guicolors"] = { opt = true },
    ["embark-theme/vim"] = { as = "embark", opt = true },
    ["arcticicestudio/nord-vim"] = { opt = true },
    ["folke/tokyonight.nvim"] = { opt = true },
    ["junegunn/seoul256.vim"] = { opt = true },
    ["rose-pine/neovim"] = { as = "rose_pine", opt = true },
    ["sainnhe/everforest"] = { opt = true },
}

-- Load all pkgs
local present, packer = pcall(require, "packer")

if present then
    vim.cmd("packadd packer.nvim")

    -- Override with default pkgs with user ones
    pkgs = require("core.utils").merge_pkgs(pkgs)

    -- load packer init options
    local init_options = require("pkgs.utils").packer_init()

    packer.init(init_options)
    packer.startup({ pkgs })
end
