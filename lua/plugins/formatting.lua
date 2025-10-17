return {
    {
        "stevearc/conform.nvim",
        event = "BufEdit",
        opts = {
            default_format_opts = {
                lsp_format = "last",
            },
            format_on_save = {
                timeout_ms = 500,
            },
        },
    },
}
