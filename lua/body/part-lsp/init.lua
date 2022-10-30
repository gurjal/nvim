local servers = require("body.part-lsp.servers")

local M = {}

M.init_lspconfig = function()
    local conf_lspconfig = require("body.part-lsp.conf-lspconfig")
    conf_lspconfig.setup()
    servers.on_attach = conf_lspconfig.on_attach
    servers.capabilities = conf_lspconfig.capabilities
    servers.init()
end

M.init_cmp = function()
    local conf_cmp = require("body.part-lsp.conf-cmp")
    conf_cmp.setup()
    servers.capabilities = conf_cmp.capabilities
    servers.init()
end

return M
