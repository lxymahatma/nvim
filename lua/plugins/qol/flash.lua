-- Search and Navigation
return {
    "folke/flash.nvim",
    event = "VeryLazy",

    ---@type Flash.Config
    opts = {
        jump = {
            autojump = true,
        },
    },
    keys = {
        { "gs",    function() require("flash").jump() end,              desc = "Flash",               mode = { "n", "x", "o" } },
        { "gS",    function() require("flash").treesitter() end,        desc = "Flash Treesitter",    mode = { "n", "x", "o" } },
        { "r",     function() require("flash").remote() end,            desc = "Remote Flash",        mode = "o" },
        { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",   mode = { "o", "x" } },
        { "<C-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search", mode = { "c" } },
    },
}
