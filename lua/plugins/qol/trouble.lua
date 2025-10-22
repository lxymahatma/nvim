-- Diagnostics list
-- TODO: Customize Keymaps
return {
    "folke/trouble.nvim",
    lazy = true,
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
    cmd = "Trouble",
}
