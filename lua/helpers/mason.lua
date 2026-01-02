local M = {}

local mr = require("mason-registry")
local mlsp = require("mason-lspconfig")
local mappings = mlsp.get_mappings().lspconfig_to_package

--- @param package_list MasonPackageSpec[] List of package names or specs to ensure are installed
function M.ensure_packages_installed(package_list)
    mr.refresh(function()
        for _, pkg_spec in ipairs(package_list) do
            local pkg_name, should_install = nil, true

            if type(pkg_spec) == "string" then
                -- { "package" }
                pkg_name = pkg_spec
            elseif type(pkg_spec) == "table" then
                pkg_name = pkg_spec[1]
                local condition = pkg_spec.condition

                if type(condition) == "function" then
                    -- { "package", condition = function() ... end }
                    --- @cast condition fun(): boolean
                    should_install = condition()
                elseif type(condition) == "table" then
                    --- @cast condition ConditionOptions
                    if condition.missing == true then
                        -- { "package", condition = { missing = true } }
                        should_install = vim.fn.executable(pkg_name) == 0
                    elseif type(condition.missing) == "string" then
                        -- { "package", condition = { missing = "executable" } }
                        should_install = vim.fn.executable(condition.missing) == 0
                    end
                end
            end

            --- @cast pkg_name string
            if should_install then M.install_package(pkg_name) end
        end
    end)
end

--- @param pkg_name string
function M.install_package(pkg_name)
    local ok, pkg = pcall(mr.get_package, mappings[pkg_name] or pkg_name)
    if not ok then
        vim.notify(("[mason.nvim] Package %s not found"):format(pkg_name), vim.log.levels.WARN)
        return
    end

    --- @cast pkg Package
    local function install_package()
        pkg:once("install:success", function()
            vim.schedule(function() vim.notify(("[mason.nvim] %s installation complete"):format(pkg_name)) end)
        end)

        pkg:once("install:failed", function()
            vim.schedule(function() vim.notify(("[mason.nvim] %s installation failed"):format(pkg_name), vim.log.levels.ERROR) end)
        end)

        pkg:install()
    end

    if not pkg:is_installed() then
        vim.notify(("[mason.nvim] installing %s"):format(pkg_name))
        install_package()
    elseif pkg:get_installed_version() ~= pkg:get_latest_version() then
        vim.notify(("[mason.nvim] updating %s"):format(pkg_name))
        install_package()
    end
end

return M
