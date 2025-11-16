return {
    provider = function(self)
        if vim.api.nvim_get_option_value("modified", { buf = self.bufnr }) then
            return " ●"
        else
            return "  "
        end
    end,
    hl = { fg = "orange" },
}
