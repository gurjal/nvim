return function()
    return {
        exe = "shfmt",
        args = {
            "-i",
            vim.opt.tabstop:get(),
        },
        stdin = true,
    }
end
