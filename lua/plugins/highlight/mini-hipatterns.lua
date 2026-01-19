--- @type LazyPluginSpec
return {
    "nvim-mini/mini.hipatterns",
    event = "BufEdit",
    opts = function()
        local hipatterns = require("mini.hipatterns")

        return {
            highlighters = {
                -- Highlight hex color codes (e.g., #FF5733)
                hipatterns.gen_highlighter.hex_color(),
            },
        }
    end,
}
