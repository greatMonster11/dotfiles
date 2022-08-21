local neogit = require('neogit')
local nnoremap = require('greatmonster11.keymap').nnoremap

neogit.setup {}

-- Just like "git status"
nnoremap("<leader>gs", function()
    neogit.open({ })
end);
