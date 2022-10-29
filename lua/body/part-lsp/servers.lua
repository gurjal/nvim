local lspconfig = require("lspconfig")

local m = {}

m.on_attach = nil
m.capabilities = nil

m.init = function()
    m.lua()
    m.c()
    m.rust()
    m.python()
    m.arduino()
end

m.lua = function()
    -- lua
    lspconfig["sumneko_lua"].setup({
        on_attach = m.on_attach,
        capabilities = m.capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    })
end

m.c = function()
    -- c, cpp
    lspconfig["clangd"].setup({
        on_attach = m.on_attach,
        capabilities = m.capabilities,
    })
end

m.rust = function()
    -- rust
    lspconfig["rust_analyzer"].setup({
        on_attach = m.on_attach,
        capabilities = m.capabilities,
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importGranularity = "module",
                    importPrefix = "self",
                },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    })
end

m.python = function()
    -- python
    lspconfig["pyright"].setup({
        on_attach = m.on_attach,
        capabilities = m.capabilities,
    })
end

m.arduino = function()
    -- arduino
    lspconfig["arduino_language_server"].setup({
        on_attach = m.on_attach,
        capabilities = m.capabilities,
        cmd = {
            "arduino-language-server",
            "-cli-config",
            "~/.arduino15/arduino-cli.yaml",
            "-fqbn",
            "arduino:avr:uno",
            "-cli",
            "arduino-cli",
            "-clangd",
            "clangd",
        },
    })
end

return m
