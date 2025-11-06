return {
    -- DAP Core
    {
        "mfussenegger/nvim-dap",
        keys = {},
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        opts = {},
        keys = {
            { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "x" } },
        },
    },

    -- Mason DAP
    {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
            automatic_installation = true,
        },
    },
}
