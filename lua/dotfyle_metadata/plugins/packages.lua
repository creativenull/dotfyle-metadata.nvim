local function get_all()
    return vim.tbl_filter(function(name)
        return not string.find(name, '.config/nvim/lua') and not string.find(name, 'nvim/runtime/lua')
    end, vim.api.nvim_get_runtime_file("lua/", true))
end

return {
    name = "packages",

    installed = function()
        return #get_all() > 0
    end,

    parse = function()
        local repos = vim.tbl_map(function(name)
            return vim.trim(vim.fn.system({
                "git",
                "-C",
                name,
                "remote",
                "get-url",
                "origin"
            }))
        end, get_all())

        repos = vim.tbl_filter(function(name)
            return not string.find(name, 'fatal: ')
        end, repos)

        return vim.tbl_map(function(name)
            local match = name:match("https?://.-/([^/]+/[^/]+)")
            if not match then
                match = name:match("[^:]+:/?/?([^/]+/[^/]+)")
            end
            if match then
                return match:gsub(".git$", "")
            end
            return nil
		end, repos)
    end,
}
