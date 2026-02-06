local map = Snacks.keymap.set

for _, km in ipairs(require("toolchain.lang.parser").get_keymaps()) do
    map(km.mode, km.lhs, km.rhs, km.opts)
end
