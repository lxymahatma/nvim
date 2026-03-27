-- Mini Icons
---@type LazyPluginSpec
return {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
        file = {
            [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
            ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        },
        filetype = {
            dotenv = { glyph = "", hl = "MiniIconsYellow" },
        },
    },
    config = function(_, opts)
        require("mini.icons").mock_nvim_web_devicons()
        require("mini.icons").setup(opts)
    end,
}
