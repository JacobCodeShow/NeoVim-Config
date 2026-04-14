-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    config = function ()
        local user_bin = vim.fn.expand("~/.local/bin")
        if vim.fn.isdirectory(user_bin) == 1 and not vim.env.PATH:find(user_bin, 1, true) then
            vim.env.PATH = user_bin .. ":" .. vim.env.PATH
        end

        local ok, treesitter = pcall(require, "nvim-treesitter")
        if not ok then
            return
        end

        treesitter.setup({
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "python",
                "bash",
                "json",
                "yaml",
                "go",
                "ini",
                "dart",
                "javascript",
                "html",
                "vue",
                "markdown",
                "markdown_inline",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            indent = {
                enable = true,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
                },
            },
        })
    end,
}