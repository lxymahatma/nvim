--- @type LanguageSpec
return {
    filetype = "dockerfile",
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
    linter = "hadolint",
}
