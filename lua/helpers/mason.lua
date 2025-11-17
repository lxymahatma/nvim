local M = {}

local mr = require("mason-registry")
local mlsp = require("mason-lspconfig")
local mappings = mlsp.get_mappings().lspconfig_to_package

---@alias PackageSpec string | { [1]: string, condition: fun(): boolean }
---@param package_list PackageSpec[]
function M.ensure_packages_installed(package_list)
    mr.refresh(function()
        for _, pkg_spec in ipairs(package_list) do
            local pkg_name, should_install

            if type(pkg_spec) == "string" then
                pkg_name = pkg_spec
                should_install = true
            elseif type(pkg_spec) == "table" then
                pkg_name = pkg_spec[1]
                should_install = pkg_spec.condition()
            end

            ---@cast pkg_name string
            if should_install then M.install_package(pkg_name) end
        end
    end)
end

---@param pkg_name string
function M.install_package(pkg_name)
    local ok, pkg = pcall(mr.get_package, mappings[pkg_name] or pkg_name)
    if not ok then
        vim.notify(("[mason.nvim] Package %s not found"):format(pkg_name), vim.log.levels.WARN)
        return
    end

    ---@cast pkg Package
    pkg:once("install:success", function()
        vim.schedule(function() vim.notify(("[mason.nvim] %s installation complete"):format(pkg_name)) end)
    end)
    pkg:once("install:failed", function()
        vim.schedule(function() vim.notify(("[mason.nvim] %s installation failed"):format(pkg_name), vim.log.levels.ERROR) end)
    end)

    if not pkg:is_installed() then
        vim.notify(("[mason.nvim] installing %s"):format(pkg_name))
        pkg:install()
    else
        if pkg:get_installed_version() ~= pkg:get_latest_version() then
            vim.notify(("[mason.nvim] updating %s"):format(pkg_name))
            pkg:install()
        end
    end
end

return M
