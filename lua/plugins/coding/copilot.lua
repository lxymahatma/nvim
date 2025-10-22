-- Copilot
return {
    {
        "github/copilot.vim",
        event = "BufEdit",
        build = ":Copilot setup",
    },
}
