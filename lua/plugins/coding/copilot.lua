-- Copilot
return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "BufEdit",
    build = ":Copilot auth",

    ---@type CopilotConfig
    opts = {
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = {
                accept = false,
            },
        },
        nes = {
            enabled = false,
        },
    },
}
