-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    -- ⭐ 推荐：启动即加载（Treesitter 是基础设施）
    event = { "BufReadPost", "BufNewFile" },

    config = function ()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
            return
        end

        configs.setup({
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
            },
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