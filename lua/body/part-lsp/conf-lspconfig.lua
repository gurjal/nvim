local utils = require("core.utils")

local m = {}

m.on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    utils.load_mappings("lspconfig", { buffer = bufnr })
end

m.capabilities = vim.lsp.protocol.make_client_capabilities()

m.setup = function()
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return m
