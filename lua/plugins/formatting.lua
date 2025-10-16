return {
    {
        "stevearc/conform.nvim",
        lazy = true,
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "last",
            },
        },
    },
}
