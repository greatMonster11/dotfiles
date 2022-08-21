local colors = require("colorbuddy.color").colors

local ns_gm11 = vim.api.nvim_create_namespace "gm11_colors"
local ns_gm11_2 = vim.api.nvim_create_namespace "gm11_colors_2"

vim.api.nvim_set_decoration_provider(ns_gm11, {
  on_start = function(_, tick)
  end,

  on_buf = function(_, bufnr, tick)
  end,

  on_win = function(_, winid, bufnr, topline, botline)
  end,

  on_line = function(_, winid, bufnr, row)
    if row == 10 then
      vim.api.nvim_set_hl_ns(ns_gm11_2)
    else
      vim.api.nvim_set_hl_ns(ns_gm11)
    end
  end,

  on_end = function(_, tick)
  end,
})

vim.api.nvim_set_hl(ns_gm11, "LuaFunctionCall", {
  foreground = colors.green:to_rgb(),
  background = nil,
  reverse = false,
  underline = false,
})

vim.api.nvim_set_hl_ns(ns_gm11)
