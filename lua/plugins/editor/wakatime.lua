---@type LazyPluginSpec
return {
    "wakatime/vim-wakatime",
    lazy = false,
    init = function() vim.g.loaded_wakatime = 1 end,
    opts = {},
}
