-- Inline diagnostic messages
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    opts = {
        preset = "classic",
        transparent_bg = false,
        transparent_cursorline = true,
        disabled_ft = { "lazy" },
        options = {
            throttle = 20,
            show_source = {
                enabled = true,
            },
            multilines = {
                enabled = true,
                always_show = true,
            },
            show_related = {
                enabled = true,
                max_count = 3,
            },
        },
    },
    config = function(_, opts)
        local tiny_inline = require("tiny-inline-diagnostic")
        tiny_inline.setup(opts)

        local disabled = false
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
}
