-- Diagnostics list
-- TODO: Customize Keymaps
return {
    "folke/trouble.nvim",
    opts = {
        modes = {
            lsp = {
                win = { position = "right" },
            },
        },
    },
    cmd = "Trouble",
    keys = {},
}
