vim.api.nvim_create_user_command("Toolchain", function() require("toolchain.ui").open() end, { desc = "Open toolchain manager UI" })
