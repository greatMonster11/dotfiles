-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

USER = vim.fn.expand('$USER')

local sumneko_root_path = "/home/" .. USER .. "/.config/lua-language-server"
local sumneko_binary = "/home/" .. USER .. "/.config/lua-language-server/bin/Linux/lua-language-server"

local function on_attach()
    -- Try to replace lsp.vim file
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
end

require'lspconfig'.tsserver.setup{capabilities = capabilities, on_attach=on_attach }

require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function() return vim.loop.cwd() end
}

require'lspconfig'.pyright.setup{
    capabilities = capabilities,
    on_attach=on_attach
}

require'lspconfig'.gopls.setup{
    capabilities = capabilities,
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
require'lspconfig'.rust_analyzer.setup{
    capabilities = capabilities,
    on_attach=on_attach
}

-- Lua LSP
require'lspconfig'.sumneko_lua.setup{
    capabilities = capabilities,
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

local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
