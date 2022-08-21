local sumneko_root_path = "C:\\Users\\npthanh\\lua-language-server"
local sumneko_binary = sumneko_root_path .. "\\bin\\lua-language-server.exe"

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

-- Local mapping
local imap = function(tbl)
  vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end
local nmap = function(tbl)
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

local handlers = require "greatmonster11.lsp.handlers"
local lspconfig_util = require "lspconfig.util"

local ok, nvim_status = pcall(require, "lsp-status")
if not ok then
  nvim_status = nil
end

local status = require "greatmonster11.lsp.status"
if status then
  status.activate()
end

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local augroup_format = vim.api.nvim_create_augroup("my_lsp_format", { clear = true })
local autocmd_format = function(async, filter)
  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = 0,
    callback = function()
      vim.lsp.buf.format { async = async, filter = filter }
    end,
  })
end

local filetype_attach = setmetatable({
  go = function()
    autocmd_format(false)
  end,

  typescript = function()
    autocmd_format(false, function(clients)
      return vim.tbl_filter(function(client)
        return client.name ~= "tsserver"
      end, clients)
    end)
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  if nvim_status then
    nvim_status.on_attach(client)
  end

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }
  end

  buf_nnoremap { "gd", function() vim.lsp.buf.definition() end }
  buf_nnoremap { "K", function() vim.lsp.buf.hover() end }
  buf_nnoremap { "<leader>vws", function() vim.lsp.buf.workspace_symbol() end }
  buf_nnoremap { "<leader>vd", function() vim.diagnostic.open_float() end }
  buf_nnoremap { "[d", function() vim.diagnostic.goto_next() end }
  buf_nnoremap { "]d", function() vim.diagnostic.goto_prev() end }
  buf_nnoremap { "<leader>vca", function() vim.lsp.buf.code_action() end }
  buf_nnoremap { "<leader>vrr", function() vim.lsp.buf.references() end }
  buf_nnoremap { "<leader>vrn", function() vim.lsp.buf.rename() end }
  buf_nnoremap { "<leader>vf", function() vim.lsp.buf.format({ async = true }) end }
  buf_inoremap { "<C-h>", function() vim.lsp.buf.signature_help() end }

  buf_nnoremap { "<space>gI", handlers.implementation }
  buf_nnoremap { "<space>lr", "<cmd>lua R('greatmonster11.lsp.codelens').run()<CR>" }
  buf_nnoremap { "<space>lrr", "LspRestart" }

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
if nvim_status then
  updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
end
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

-- vim.lsp.buf_request(0, "textDocument/codeLens", { textDocument = vim.lsp.util.make_text_document_params() })

local servers = {
    pyright = true,

    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
        },
        -- Required for lsp-status
        init_options = {
            clangdFileStatus = true,
        },
        handlers = nvim_status and nvim_status.extensions.clangd.setup() or nil,
    },

    sumneko_lua = {
        cmd = { sumneko_binary, "-E", sumneko_root_path .. "\\main.lua" },
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                    -- Setup your lua path
                    path = vim.split(package.path, ";"),
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                        -- vim
                        "vim",

                        -- Busted
                        "describe",
                        "it",
                        "before_each",
                        "after_each",
                        "teardown",
                        "pending",
                        "clear",

                        -- Colorbuddy
                        "Color",
                        "c",
                        "Group",
                        "g",
                        "s",

                        -- Custom
                        "RELOAD",
                    },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand("$VIMRUNTIME\\lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME\\lua\\vim\\lsp")] = true,
                    },
                },
            },
        },
    },

    gopls = {
        root_dir = function(fname)
            local Path = require "plenary.path"

            local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
            local absolute_fname = Path:new(fname):absolute()

            if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
                return absolute_cwd
            end

            return lspconfig_util.root_pattern("go.mod", ".git")(fname)
        end,

        settings = {
            gopls = {
                codelenses = { test = true },
            },
        },

        flags = {
            debounce_text_changes = 200,
        },
    },

    tsserver = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },

        on_attach = function(client)
            custom_attach(client)
        end,
    },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

-- Set up null-ls
local use_null = true
if use_null then
  require("null-ls").setup {
    sources = {
      -- require("null-ls").builtins.formatting.stylua,
      -- require("null-ls").builtins.diagnostics.eslint,
      -- require("null-ls").builtins.completion.spell,
      -- require("null-ls").builtins.diagnostics.selene,
      require("null-ls").builtins.formatting.prettierd,
    },
  }
end

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
