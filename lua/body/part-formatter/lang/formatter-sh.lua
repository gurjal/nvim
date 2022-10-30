return function()
    return {
        exe = "shfmt",
        args = {
            "--func-next-line",
            "--indent",
            vim.opt.tabstop:get(),
        },
        stdin = true,
    }
end
