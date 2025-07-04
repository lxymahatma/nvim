return {
    name = "clangd build",
    builder = function()
        local file = vim.fn.expand("%:p")
        return {
            cmd = { "clang" },
            args = { file },
            components = {
                { "on_output_quickfix", open = true },
                "default",
            },
        }
    end,
    condition = {
        filetype = {
            "c",
            "cpp",
        },
    },
}
