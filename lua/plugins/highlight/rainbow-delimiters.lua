-- Rainbow Brackets
return {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufEdit",
    main = "rainbow-delimiters.setup",

    ---@type rainbow_delimiters.config
    opts = {
        strategy = {
            [""] = "rainbow-delimiters.strategy.global",
            vim = "rainbow-delimiters.strategy.local",
        },
        query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
        },
        priority = {
            [""] = 110,
            lua = 210,
        },
        highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
        },
    },
}
