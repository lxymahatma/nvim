local config = {}

require("config.lazy")

if vim.g.vscode then
    require("config.vscode-options")
else
    config.colorscheme = "catppuccin"

    require("config.neovim-options")
    require("config.colorschemes").setup(config.colorscheme)
end
