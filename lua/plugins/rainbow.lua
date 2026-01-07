-- ~/.config/nvim/lua/plugins/rainbow.lua

return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  
  init = function()
    -- 强制定义高亮组
    vim.cmd([[
      hi! RainbowDelimiterRed    guifg=#ed8796 gui=bold
      hi! RainbowDelimiterYellow guifg=#eed49f gui=bold
      hi! RainbowDelimiterBlue   guifg=#8aadf4 gui=bold
      hi! RainbowDelimiterOrange guifg=#f5a97f gui=bold
      hi! RainbowDelimiterGreen  guifg=#a6da95 gui=bold
      hi! RainbowDelimiterViolet guifg=#c6a0f6 gui=bold
      hi! RainbowDelimiterCyan   guifg=#91d7e3 gui=bold
    ]])
  end,
  
  config = function()
    local rainbow = require('rainbow-delimiters')
    
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow.strategy['global'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        c = 'rainbow-delimiters',
        cpp = 'rainbow-delimiters',
        python = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      }
    }

    -- 🎯 关键修复：正确的缓冲区激活函数
    local function activate_rainbow_for_buffer(buf)
      if not vim.api.nvim_buf_is_valid(buf) then return end
      
      local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      if ft == '' then return end
      
      -- 设置缓冲区变量
      vim.b[buf].rainbow_delimiters_active = true
      
      -- 延迟执行，确保Treesitter就绪
      vim.defer_fn(function()
        if rainbow.is_enabled() then
          -- 获取解析器并确保查询应用
          local parser = vim.treesitter.get_parser(buf, ft)
          if parser then
            -- 重新解析以触发查询
            parser:invalidate()
            vim.treesitter.start(buf, ft)
          end
        end
      end, 100)
    end

    -- 自动命令：为新缓冲区激活
    vim.api.nvim_create_autocmd({"BufEnter", "FileType"}, {
      group = vim.api.nvim_create_augroup("RainbowDelimitersAuto", { clear = true }),
      callback = function(args)
        local buf = args.buf
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        
        -- 支持的代码文件类型
        local code_fts = {
          c = true, cpp = true, lua = true, python = true,
          javascript = true, typescript = true, java = true,
          go = true, rust = true, sh = true, bash = true,
          html = true, css = true, json = true, yaml = true,
        }
        
        if code_fts[ft] and ft ~= "" then
          activate_rainbow_for_buffer(buf)
        end
      end
    })

    -- 为现有缓冲区激活
    vim.defer_fn(function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
          local code_fts = { c = true, cpp = true, lua = true, python = true }
          if code_fts[ft] then
            activate_rainbow_for_buffer(buf)
          end
        end
      end
      print("🌈 rainbow-delimiters.nvim 已配置完成")
    end, 1000)
  end
}
