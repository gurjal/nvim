local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs
M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- lua
lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- rust
lspconfig["rust_analyzer"].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
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
}

-- c, cpp
lspconfig["clangd"].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

-- python
lspconfig["pyright"].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

-- arduino
lspconfig["arduino_language_server"].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
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
}

return M
