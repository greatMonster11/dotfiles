-- General configuration
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparent_sidebar = true

vim.g.tokyonight_style = "night" -- background = "dark"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]

local hl = function(thing, opt)
    vim.api.nvim_set_hl(0, thing, opt)
end

hl("SignColumn", {
    bg = "none",
})

hl("ColorColumn", {
    ctermbg = 0,
    bg = "#555555",
})

hl("CursorLineNR", {
    bg = "None"
})

hl("Normal", {
    bg = "none"
})

hl("netrwDir", {
    fg = "#5eacd3"
})
