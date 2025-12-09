---@type LanguageSpec
return {
    treesitter = "dockerfile",
    mason = {
        "docker_compose_language_service",
        "docker_language_server",
        "dockerls",
        "hadolint",
    },
    lsp = {
        "docker_compose_language_service",
        "docker_language_server",
        "dockerls",
    },
    linter = {
        dockerfile = { "hadolint" },
    },
}
