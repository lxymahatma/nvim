local map = vim.keymap.set

local function action(cmd)
    return function()
        require("vscode").action(cmd)
    end
end


vim.opt.clipboard = "unnamedplus"

-- Split Editor and Focus Group Keybindings
map("n", "<Leader>s", action("workbench.action.splitEditor"))
map("n", "<Leader>fh", action("workbench.action.focusLeftGroup"))
map("n", "<Leader>fl", action("workbench.action.focusRightGroup"))
map("n", "<Leader>fj", action("workbench.action.focusDownGroup"))
map("n", "<Leader>fk", action("workbench.action.focusUpGroup"))

map("n", "<Leader><Leader>sh", action("workbench.action.splitEditorLeft"))
map("n", "<Leader><Leader>sl", action("workbench.action.splitEditorRight"))
map("n", "<Leader><Leader>sj", action("workbench.action.splitEditorDown"))
map("n", "<Leader><Leader>sk", action("workbench.action.splitEditorUp"))

map("n", "<Leader>/", action("workbench.action.findInFiles"))
