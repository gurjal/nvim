local pkgs = {

    ["lewis6991/impatient.nvim"] = {},

    ["nvim-lua/plenary.nvim"] = { module = "plenary" },

    ["wbthomason/packer.nvim"] = {
        cmd = require("core.lazy_load").packer_cmds,
        config = function() require("pkgs") end,
    },

    ["kyazdani42/nvim-web-devicons"] = {
        module = "nvim-web-devicons",
        config = function() require("body.part-others").devicons() end,
    },

    ["NvChad/nvim-colorizer.lua"] = {
        opt = true,
        setup = function() require("core.lazy_load").on_file_open("nvim-colorizer.lua") end,
        config = function() require("body.part-others").colorizer() end,
    },

    ["nvim-treesitter/nvim-treesitter"] = {
        module = "nvim-treesitter",
        setup = function() require("core.lazy_load").on_file_open("nvim-treesitter") end,
        cmd = require("core.lazy_load").treesitter_cmds,
        run = ":TSUpdate",
        config = function() require("body.part-treesitter").init() end,
    },

    -- git stuff
    ["lewis6991/gitsigns.nvim"] = {
        ft = "gitcommit",
        setup = function() require("core.lazy_load").gitsigns() end,
        config = function() require("body.part-others").gitsigns() end,
    },

    -- lsp stuff
    ["neovim/nvim-lspconfig"] = {
        opt = true,
        setup = function() require("core.lazy_load").on_file_open("nvim-lspconfig") end,
        config = function() require("body.part-lsp").init_lspconfig() end,
    },

    -- load luasnips + cmp related in insert mode only
    ["rafamadriz/friendly-snippets"] = {
        module = { "cmp", "cmp_nvim_lsp" },
        event = { "InsertEnter", "CmdlineEnter" },
    },
    ["hrsh7th/nvim-cmp"] = { after = "friendly-snippets" },
    ["L3MON4D3/LuaSnip"] = { after = "nvim-cmp" },
    ["saadparwaiz1/cmp_luasnip"] = {
        after = "LuaSnip",
        config = function() require("body.part-others").luasnip() end,
    },
    ["hrsh7th/cmp-nvim-lua"] = { after = "LuaSnip" },
    ["hrsh7th/cmp-nvim-lsp"] = { after = "cmp-nvim-lua" },
    ["hrsh7th/cmp-buffer"] = { after = "cmp-nvim-lsp" },
    ["hrsh7th/cmp-path"] = { after = "cmp-buffer" },
    ["hrsh7th/cmp-cmdline"] = {
        after = "cmp-path",
        config = function() require("body.part-lsp").init_cmp() end,
    },

    ["windwp/nvim-autopairs"] = {
        after = "nvim-cmp",
        config = function() require("body.part-autopairs").init() end,
    },

    ["rcarriga/nvim-notify"] = {
        module = "notify",
        config = function() require("body.part-notify").init() end,
    },

    ["MunifTanjim/nui.nvim"] = { module = "nui" },

    ["nvim-neo-tree/neo-tree.nvim"] = {
        cmd = "Neotree",
        setup = function() require("core.utils").load_mappings("neotree") end,
        config = function() require("body.part-neotree").init() end,
    },

    -- formatting
    ["mhartington/formatter.nvim"] = {
        cmd = "FormatWrite",
        setup = function() require("core.utils").load_mappings("formatter") end,
        config = function() require("body.part-formatter").init() end,
    },

    ["ojroques/nvim-hardline"] = { module = "hardline" },

    ["kylechui/nvim-surround"] = {
        module = "nvim-surround",
        event = "VimEnter",
        config = function() require("nvim-surround").setup() end,
    },

    ["junegunn/vim-easy-align"] = {
        setup = function() require("core.utils").load_mappings("vim_easy_align") end,
    },

    ["numToStr/Comment.nvim"] = {
        module = "Comment",
        config = function() require("body.part-others").comment() end,
        setup = function() require("core.utils").load_mappings("comment") end,
    },

    ["nvim-telescope/telescope.nvim"] = {
        cmd = "Telescope",
        config = function() require("body.part-telescope") end,
        setup = function() require("core.utils").load_mappings("telescope") end,
    },

    ["folke/which-key.nvim"] = { module = "which-key" },

    ["folke/twilight.nvim"] = { module = "twilight" },

    ["folke/zen-mode.nvim"] = {
        cmd = "ZenMode",
        wants = "twilight.nvim",
        setup = function() require("core.utils").load_mappings("zenmode") end,
        config = function() require("body.part-zenmode") end,
    },

    ["tpope/vim-repeat"] = { module = "vim-repeat" },

    ["ggandor/leap.nvim"] = {
        module = "leap",
        wants = "vim-repeat",
        keys = { "s", "S", "x", "X" },
        config = function() require("body.part-leap").init() end,
    },
    ["ggandor/leap-ast.nvim"] = {
        module = "leap-ast",
        wants = "leap.nvim",
        setup = function() require("core.utils").load_mappings("leap_ast") end,
    },

    ["mickael-menu/zk-nvim"] = {
        ft = { "markdown" },
        cmd = require("core.lazy_load").zk_cmds,
        setup = function() require("core.utils").load_mappings("zk") end,
        config = function() require("body.part-zk") end,
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
    local pkg_table = {}
    for key, _ in pairs(pkgs) do
        pkgs[key][1] = key
        pkg_table[#pkg_table + 1] = pkgs[key]
    end
    vim.cmd("packadd packer.nvim")
    packer.init({
        auto_clean = true,
        compile_on_sync = true,
        git = { clone_timeout = 6000 },
        display = { open_fn = function() return require("packer.util").float({ border = "single" }) end },
    })
    packer.startup({ pkg_table })
end
