-- Copilot
--- @type LazyPluginSpec
return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufEdit",

    --- @type CopilotConfig
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
                accept = false,
            },
        },
        nes = {
            enabled = false,
        },
    },
    config = function(_, opts)
        require("copilot").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function() vim.b.copilot_suggestion_hidden = true end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function() vim.b.copilot_suggestion_hidden = false end,
        })
    end,
}
