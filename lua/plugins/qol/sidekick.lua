-- AI sidekick
return {
    "folke/sidekick.nvim",
    Event = "VeryLazy",

    ---@type sidekick.Config
    opts = {
        cli = {
            mux = {
                backend = "tmux",
                enabled = true,
            },
        },
    },
    config = function(_, opts)
        require("sidekick").setup(opts)

        local disabled = false
        local tiny_inline = require("tiny-inline-diagnostic")

        vim.api.nvim_create_autocmd("User", {
            pattern = "SidekickNesHide",
            callback = function()
                if disabled then
                    disabled = false
                    tiny_inline.enable()
                end
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "SidekickNesShow",
            callback = function()
                disabled = true
                tiny_inline.disable()
            end,
        })
    end,
    keys = {
        {
            "<Tab>",
            function()
                if not require("sidekick").nes_jump_or_apply() then return "<Tab>" end
            end,
            expr = true,
            desc = "Goto/Apply Next Edit Suggestion",
        },
        {
            "<C-.>",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle",
            mode = { "n", "t", "i", "x" },
        },
        {
            "<leader>aa",
            function() require("sidekick.cli").toggle() end,
            desc = "Sidekick Toggle CLI",
        },
        {
            "<leader>as",
            function() require("sidekick.cli").select() end,
            desc = "Select CLI",
        },
        {
            "<leader>ad",
            function() require("sidekick.cli").close() end,
            desc = "Detach a CLI Session",
        },
        {
            "<leader>at",
            function() require("sidekick.cli").send({ msg = "{this}" }) end,
            mode = { "x", "n" },
            desc = "Send This",
        },
        {
            "<leader>af",
            function() require("sidekick.cli").send({ msg = "{file}" }) end,
            desc = "Send File",
        },
        {
            "<leader>av",
            function() require("sidekick.cli").send({ msg = "{selection}" }) end,
            mode = { "x" },
            desc = "Send Visual Selection",
        },
    },
}
