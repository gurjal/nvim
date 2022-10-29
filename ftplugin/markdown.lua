-- Add the key mappings only for Markdown files in a zk notebook.
if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
    local function map(...)
        vim.api.nvim_buf_set_keymap(0, ...)
    end

    local opts = { noremap = true, silent = false }

    -- Open the link under the caret.
    map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    -- Create a new note after asking for its title.
    -- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
    map("n", "<space>zn", "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    map("v", "<space>znt", ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", opts)
    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    map(
        "v",
        "<space>znc",
        ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
        opts
    )

    -- Open notes linking to the current buffer.
    map("n", "<space>zb", "<Cmd>ZkBacklinks<CR>", opts)
    -- Alternative for backlinks using pure LSP and showing the source context.
    --map('n', '<space>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Open notes linked by the current buffer.
    map("n", "<space>zl", "<Cmd>ZkLinks<CR>", opts)

    -- Preview a linked note.
    map("n", "<space>k", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- Open the code actions for a visual selection.
    map("v", "<space>za", ":'<,'>lua vim.lsp.buf.range_code_action()<CR>", opts)
end