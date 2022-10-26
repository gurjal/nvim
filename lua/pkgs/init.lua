local pkgs = {

    ["lewis6991/impatient.nvim"] = {},

    ["nvim-lua/plenary.nvim"] = { module = "plenary" },

    ["tpope/vim-repeat"] = {},

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
            require("pkgs.configs.mod-others").devicons()
        end,
    },

    ["NvChad/nvim-colorizer.lua"] = {
        opt = true,
        setup = function()
            require("core.lazy_load").on_file_open("nvim-colorizer.lua")
        end,
        config = function()
            require("pkgs.configs.mod-others").colorizer()
        end,
    },

    ["nvim-treesitter/nvim-treesitter"] = {
        module = "nvim-treesitter",
        setup = function()
            require("core.lazy_load").on_file_open("nvim-treesitter")
        end,
        cmd = require("core.lazy_load").treesitter_cmds,
        run = ":TSUpdate",
        config = function()
            require("pkgs.configs.mod-treesitter")
        end,
    },

    -- git stuff
    ["lewis6991/gitsigns.nvim"] = {
        ft = "gitcommit",
        setup = function()
            require("core.lazy_load").gitsigns()
        end,
        config = function()
            require("pkgs.configs.mod-others").gitsigns()
        end,
    },

    -- lsp stuff
    ["neovim/nvim-lspconfig"] = {
        opt = true,
        setup = function()
            require("core.lazy_load").on_file_open("nvim-lspconfig")
        end,
        config = function()
            require("pkgs.configs.mod-lspconfig")
        end,
    },

    -- load luasnips + cmp related in insert mode only
    ["rafamadriz/friendly-snippets"] = {
        module = { "cmp", "cmp_nvim_lsp" },
        event = "InsertEnter",
    },

    ["hrsh7th/nvim-cmp"] = {
        after = "friendly-snippets",
        config = function()
            require("pkgs.configs.mod-cmp")
        end,
    },

    ["L3MON4D3/LuaSnip"] = {
        wants = "friendly-snippets",
        after = "nvim-cmp",
        config = function()
            require("pkgs.configs.mod-others").luasnip()
        end,
    },
    ["onsails/lspkind.nvim"] = { after = "LuaSnip" },
    ["saadparwaiz1/cmp_luasnip"] = { after = "lspkind.nvim" },
    ["hrsh7th/cmp-nvim-lua"] = { after = "cmp_luasnip" },
    ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp-nvim-lua" },
    ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
    ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },

    -- formatting
    ["mhartington/formatter.nvim"] = {
        opt = true,
        setup = function()
            require("core.utils").load_mappings("formatter")
        end,
    },

    -- misc pkgs
    ["windwp/nvim-autopairs"] = {
        after = "nvim-cmp",
        config = function()
            require("pkgs.configs.mod-others").autopairs()
        end,
    },

    ["kylechui/nvim-surround"] = {
        after = "nvim-autopairs",
        config = function()
            require("nvim-surround").setup()
        end,
    },

    ["numToStr/Comment.nvim"] = {
        module = "Comment",
        keys = { "gc", "gb" },
        config = function()
            require("pkgs.configs.mod-others").comment()
        end,
        setup = function()
            require("core.utils").load_mappings("comment")
        end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        cmd = "Telescope",
        config = function()
            require("pkgs.configs.mod-telescope")
        end,
        setup = function()
            require("core.utils").load_mappings("telescope")
        end,
    },

    ["ojroques/nvim-hardline"] = {
        event = "UIEnter",
        config = function()
            require("pkgs.configs.mod-hardline")
        end,
    },

    ["MunifTanjim/nui.nvim"] = { cmd = "Neotree" },

    ["nvim-neo-tree/neo-tree.nvim"] = {
        after = "nui.nvim",
        config = function()
            require("pkgs.configs.mod-others").neotree()
        end,
        setup = function()
            require("core.utils").load_mappings("neotree")
        end,
    },

    -- Only load whichkey after all the gui
    ["folke/which-key.nvim"] = {
        event = "UIEnter",
        config = function()
            require("pkgs.configs.mod-whichkey")
        end,
    },

    ["folke/zen-mode.nvim"] = {
        opt = true,
        setup = function()
            require("core.utils").load_mappings("zenmode")
        end,
    },
    ["folke/twilight.nvim"] = { opt = true },

    ["rcarriga/nvim-notify"] = {
        event = "UIEnter",
        config = function()
            require("pkgs.configs.mod-notify")
        end,
    },

    ["ggandor/leap.nvim"] = {
        keys = { "s", "S", "x", "X" },
        config = function()
            require("leap").add_default_mappings()
        end,
    },

    ["ggandor/flit.nvim"] = {
        after = "leap.nvim",
        config = function()
            require("flit").setup()
        end,
    },

    ["mickael-menu/zk-nvim"] = {
        ft = { "markdown" },
        cmd = require("core.lazy_load").zk_cmds,
        setup = function()
            require("core.utils").load_mappings("zk")
        end,
        config = function()
            require("pkgs.configs.mod-zk")
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
    local init_options = require("pkgs.configs.mod-others").packer_init()

    packer.init(init_options)
    packer.startup({ pkgs })
end
