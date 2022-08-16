local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local greatMonster11 = augroup('greatmonster11', {})
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = greatMonster11 ,
    desc = 'Trim some extra trailing whitespaces before saving buffer',
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
