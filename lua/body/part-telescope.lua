local present, telescope = pcall(require, 'telescope')

if not present then return end

local actions = require 'telescope.actions'
local options = {
    defaults = {
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --     horizontal = {
        --         promt_position = "top",
        --     },
        -- },
        -- bottom_pane = {
        --     height = 25,
        --     preview_cutoff = 120,
        --     prompt_position = 'top',
        -- },
        -- center = {
        --     height = 0.4,
        --     preview_cutoff = 40,
        --     prompt_position = 'top',
        --     width = 0.5,
        -- },
        -- cursor = {
        --     height = 0.9,
        --     preview_cutoff = 40,
        --     width = 0.8,
        -- },
        -- horizontal = {
        --     height = 0.9,
        --     preview_cutoff = 120,
        --     prompt_position = 'bottom',
        --     width = 0.8,
        -- },
        -- vertical = {
        --     height = 0.9,
        --     preview_cutoff = 40,
        --     prompt_position = 'bottom',
        --     width = 0.8,
        -- },
        mappings = {
            n = {
                ['q'] = actions.close,
            },
        },
    },
    pickers = {
        live_grep = { theme = 'dropdown' },
        buffers = { theme = 'dropdown' },
        treesitter = { theme = 'dropdown' },
        marks = { theme = 'dropdown' },
        lsp_implementations = { theme = 'dropdown' },
        lsp_document_symbols = { theme = 'dropdown' },
        lsp_dynamic_workspace_symbols = { theme = 'dropdown' },
        lsp_incoming_calls = { theme = 'dropdown' },
        lsp_outgoing_calls = { theme = 'dropdown' },
        current_buffer_fuzzy_find = { theme = 'dropdown' },
    },
}

telescope.setup(options)
