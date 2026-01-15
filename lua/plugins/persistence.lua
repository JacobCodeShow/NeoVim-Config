-- lua/plugins/persistence.lua

local function session_picker(session_dir)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local files = vim.fn.glob(session_dir .. "*.vim", false, true)
  if vim.tbl_isempty(files) then
    vim.notify("No sessions found", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Sessions",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = vim.fn.fnamemodify(entry, ":t"),
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(bufnr)
      actions.select_default:replace(function()
        actions.close(bufnr)
        require("persistence").load({ session = action_state.get_selected_entry().value })
      end)
      return true
    end,
  }):find()
end


return {
  "folke/persistence.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim", -- 明确声明依赖
  },
  opts = {
    dir = vim.fn.stdpath("state") .. "/sessions/",
    options = { "buffers", "curdir", "tabpages", "winsize" },
  },

  keys = {
    { "<leader>qs", function() require("persistence").save() end, desc = "Session Save" },
    {
        "<leader>ql",
        function()
            local persistence = require("persistence")
            local session_dir = vim.fn.stdpath("state") .. "/sessions/"
            local files = vim.fn.glob(session_dir .. "*.vim", false, true)

            if vim.tbl_isempty(files) then
            vim.notify("No session found!", vim.log.levels.WARN)
            return
            end

            persistence.load({ last = true })
        end,
        desc = "Session Load (last)",
    },
    -- { "<leader>qp", function() require("telescope").extensions.persistence.persistence() end, desc = "Session Picker (Telescope)" },
    { "<leader>qp", function()
        session_picker(vim.fn.stdpath("state") .. "/sessions/")
        end,
        desc = "Session Picker",
    },

    { "<leader>qd", function() require("persistence").stop() end, desc = "Session Disable" },
  },

  config = function(_, opts)
    local persistence = require("persistence")
    persistence.setup(opts)

    ------------------------------------------------------------------
    -- 工程级工具：清理无效 / 空 buffer window
    ------------------------------------------------------------------
    local function close_empty_windows()
      -- 给用户一个短暂的机会查看恢复的布局
      vim.defer_fn(function()
        local windows = vim.api.nvim_list_wins()
        
        -- 先收集要关闭的窗口，避免在遍历中修改列表
        local to_close = {}
        for _, win in ipairs(windows) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.api.nvim_buf_is_valid(buf) then
              local name = vim.api.nvim_buf_get_name(buf)
              local bt = vim.bo[buf].buftype
              local lines = vim.api.nvim_buf_line_count(buf)
              
              -- 更严格的条件：完全空的新缓冲区
              if name == "" and bt == "" and lines <= 1 then
                local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                if #content == 1 and content[1] == "" then
                  table.insert(to_close, win)
                end
              end
            end
          end
        end
        
        -- 逐个关闭
        for _, win in ipairs(to_close) do
          if vim.api.nvim_win_is_valid(win) then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
      end, 100) -- 延迟100ms执行
    end

    ------------------------------------------------------------------
    -- ⭐ 启动时：若无参数 & 有 session → 打开 Telescope picker
    ------------------------------------------------------------------
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   group = vim.api.nvim_create_augroup("PersistenceStartup", { clear = true }),
    --   callback = function()
    --     -- 只在无文件参数时处理
    --     if vim.fn.argc() ~= 0 then
    --       return
    --     end

    --     if not opts or not opts.dir then
    --     vim.notify("persistence opts not ready, skip auto session", vim.log.levels.WARN)
    --     return
    --     end

        
    --     -- 检查 session 目录是否存在且有文件
    --     local session_dir = opts.dir
    --     -- local session_dir = persistence.opts.dir or opts.dir
    --     local ok, files = pcall(vim.fn.glob, session_dir .. "*.vim", false, true)
    --     if not ok or vim.tbl_isempty(files or {}) then
    --       return
    --     end
        
    --     vim.defer_fn(function()
    --         -- persistence.load({ last = true })
    --         session_picker(session_dir)
    --     end, 50)


    --     -- -- 延迟执行，确保所有插件已加载
    --     -- vim.defer_fn(function()
    --     --   -- 安全地调用 telescope
    --     --   local has_telescope, _ = pcall(require, "telescope")
    --     --   if has_telescope then
    --     --     local ok_telescope, telescope = pcall(require, "telescope")
    --     --     if ok_telescope and telescope.extensions.persistence then
    --     --       telescope.extensions.persistence.persistence()
    --     --     else
    --     --       -- fallback: 直接加载最近 session
    --     --       persistence.load({ last = true })
    --     --     end
    --     --   else
    --     --     -- 没有 telescope，直接加载最近 session
    --     --     persistence.load({ last = true })
    --     --   end
    --     -- end, 50)
    --   end,
    -- })

    ------------------------------------------------------------------
    -- ⭐ 核心修复点：
    -- session 恢复完成后，统一清理多余 window
    ------------------------------------------------------------------
    vim.api.nvim_create_autocmd("User", {
    pattern = "PersistenceLoadPost",
    callback = function()
        vim.schedule(function()
            -- 1️⃣ 关闭空窗口
            close_empty_windows()
            if vim.fn.exists(":NvimTreeOpen") == 2 then
                vim.cmd("silent! NvimTreeOpen")
                vim.cmd("silent! NvimTreeRefresh")
            end
        end)
    end,
    })

    ------------------------------------------------------------------
    -- 命令行命令（保留）
    ------------------------------------------------------------------
    vim.api.nvim_create_user_command("PersistSave", function()
      persistence.save()
    end, { desc = "Save current session" })

    vim.api.nvim_create_user_command("PersistLoad", function()
      persistence.load()
    end, { desc = "Load session for cwd" })

    vim.api.nvim_create_user_command("PersistLoadLast", function()
      persistence.load({ last = true })
    end, { desc = "Load last session" })

    vim.api.nvim_create_user_command("PersistStop", function()
      persistence.stop()
    end, { desc = "Stop session restoration" })

    -- vim.api.nvim_create_user_command("PersistList", function()
    --   require("telescope").extensions.persistence.persistence()
    -- end, { desc = "List sessions (Telescope)" })
    vim.api.nvim_create_user_command("PersistList", function()
        session_picker(opts.dir)
    end, { desc = "List sessions" })

  end,
}
