-- ~/.config/nvim/lua/plugins/neoconfig.lua

-- 这个neoconfig.lua作为lazy的插件，被lazy管理

return {
  {
    -- 使用本地路径插件
    dir = vim.fn.stdpath("config") .. "/lua/core",  -- 指向 core 目录
    name = "neoconfig",                             -- 插件名字，可以自定义
    lazy = false,                                   -- false 表示启动时立即加载
    config = function()
      require("core.neoconfig")                     -- 执行你的配置
    end,
  },
}