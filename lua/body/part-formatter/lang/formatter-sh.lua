local args = {
            "--func-next-line",
            "--indent",
            vim.opt.tabstop:get(),

indent_style = space,
indent_size = 4,

shell_variant      = posix ,
binary_next_line   = true,
switch_case_indent = true  ,
space_redirects    = true,
keep_padding       = true,
function_next_line = true,
}

-- return function()
--     return {
--         exe = "shfmt",
--         args = {
--             "--func-next-line",
--             "--indent",
--             vim.opt.tabstop:get(),
--             indent_style = space,
--         indent_size = 4,
--
-- shell_variant      = posix ,
-- binary_next_line   = true,
-- switch_case_indent = true  ,
-- space_redirects    = true,
-- keep_padding       = true,
-- function_next_line = true,
--         },
--         stdin = true,
--     }
-- end
