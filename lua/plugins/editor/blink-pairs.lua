--- @type LazyPluginSpec
return {
    "saghen/blink.pairs",
    event = "BufEdit",
    version = "*",
    dependencies = "saghen/blink.download",

    --- @type blink.pairs.Config
    opts = {
        mappings = {
            enabled = true,
            cmdline = true,
            disabled_filetypes = {},
            pairs = {},
        },
        highlights = {
            enabled = true,
            cmdline = true,
            groups = {
                "BlinkPairsRed",
                "BlinkPairsYellow",
                "BlinkPairsBlue",
                "BlinkPairsOrange",
                "BlinkPairsGreen",
                "BlinkPairsViolet",
                "BlinkPairsCyan",
            },
            unmatched_group = "BlinkPairsUnmatched",

            matchparen = {
                enabled = true,
                cmdline = false,
                include_surrounding = false,
                group = "BlinkPairsMatchParen",
                priority = 250,
            },
        },
        debug = false,
    },
}
