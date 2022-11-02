local servers = require("body.part-lsp.servers")

local M = {}

M.init_lspconfig = function()
    local conf_lspconfig = require("body.part-lsp.conf-lspconfig")
    conf_lspconfig.init()
    servers.init(conf_lspconfig.on_attach, conf_lspconfig.capabilities)
end

M.init_cmp = function()
    local conf_lspconfig = require("body.part-lsp.conf-lspconfig")
    local conf_cmp = require("body.part-lsp.conf-cmp")
    conf_cmp.init()
    servers.init(conf_lspconfig.on_attach, conf_cmp.capabilities)
end

return M
