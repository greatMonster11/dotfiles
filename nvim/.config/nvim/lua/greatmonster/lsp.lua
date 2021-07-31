USER = vim.fn.expand('$USER')

local sumneko_root_path = "/home/" .. USER .. "/.config/lua-language-server"
local sumneko_binary = "/home/" .. USER .. "/.config/lua-language-server/bin/Linux/lua-language-server"

local function on_attach()
    -- TODO: TJ told me to do this and I should do it because he is Telescopic
    -- "Big Tech" "Cash Money" Johnson
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }

require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.pyright.setup{ on_attach=on_attach }

require'lspconfig'.gopls.setup{
    on_attach=on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
-- who even uses this?
require'lspconfig'.rust_analyzer.setup{ on_attach=on_attach }

-- Lua LSP
require'lspconfig'.sumneko_lua.setup{
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

-- symbols-outline.nvim
local opts = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false, -- experimental
    position = 'right',
    keymaps = {
        close = "<Esc>",
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        rename_symbol = "r",
        code_actions = "a"
    },
    lsp_blacklist = {}
}

require('symbols-outline').setup(opts)

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

