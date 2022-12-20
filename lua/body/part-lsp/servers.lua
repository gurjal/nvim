local lspconfig = require("lspconfig")

local M = {}

local on_attach = nil
local capabilities = nil

M.init = function(_on_attach, _capabilities )
    on_attach=_on_attach
    capabilities=_capabilities
    M.lua()
    M.c()
    M.rust()
    M.python()
    M.arduino()
end

M.lua = function()
    -- lua
    lspconfig["sumneko_lua"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
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

M.c = function()
    -- c, cpp
    lspconfig["clangd"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

M.rust = function()
    -- rust
    lspconfig["rust_analyzer"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
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

M.python = function()
    -- python
    require'lspconfig'.pylsp.setup{}
end

M.arduino = function()
    -- arduino
    lspconfig["arduino_language_server"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
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

return M
