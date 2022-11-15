return function()
  return {
    exe = "rustfmt",
    args = {
      "--config ",
      "tab_spaces=" .. vim.opt.tabstop:get()
      ..',brace_style="AlwaysNextLine"',
      " ",
    },
    stdin = true,
  }
end
