--- @meta

-- Mason Package Specification
--- @class ConditionOptions
--- @field missing? string|boolean If string, checks that specific executable. If true, use the package name as executable name.

--- @alias ConditionSpec fun(): boolean | ConditionOptions

--- @class MasonPackageStruct
--- @field [1] string Package name
--- @field condition? ConditionSpec

--- @alias MasonPackageSpec string | MasonPackageStruct

-- Types for Snacks Pickers
--- @class snacks.picker
--- @field filetypes fun(opts?:snacks.picker.filetypes.Config|{}): snacks.Picker
--- @field todo_comments fun(opts?:snacks.picker.todo.Config|{}): snacks.Picker

-- Filetype Picker
--- @class snacks.picker.filetypes.Config : snacks.picker.Config

--- @class FiletypeInfo : snacks.picker.Item
--- @field treesitter string[]
--- @field lsp string[]
--- @field formatters string[]
--- @field linters string[]
--- @field has_config boolean
