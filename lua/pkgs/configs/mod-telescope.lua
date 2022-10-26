local present, telescope = pcall(require, "telescope")

if not present then
    return
end

local options = {
    defaults = {},
    pickers = {
        live_grep = { theme = "dropdown" },
        buffers = { theme = "dropdown" },
        treesitter = { theme = "dropdown" },
        lsp_implementations = { theme = "dropdown" },
        lsp_document_symbols = { theme = "dropdown" },
        lsp_dynamic_workspace_symbols = { theme = "dropdown" },
        lsp_incoming_calls = { theme = "dropdown" },
        lsp_outgoing_calls = { theme = "dropdown" },
    },
}

telescope.setup(options)
