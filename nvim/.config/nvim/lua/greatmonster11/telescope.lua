local actions = require("telescope.actions")
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup({
    defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        multi_icon = "<>",

        color_devicons = true,

        winblend = 0,

        layout_strategy = "horizontal",
        layout_config = {
            width = 0.95,
            height = 0.85,
            -- preview_cutoff = 120,
            prompt_position = "top",

            horizontal = {
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.4)
                    else
                        return math.floor(cols * 0.6)
                    end
                end,
            },

            vertical = {
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                horizontal = {
                    preview_width = 0.9,
                },
            },
        },

        selection_strategy = "reset",
        sorting_strategy = "descending",
        scroll_strategy = "cycle",

        file_sorter = require("telescope.sorters").get_fzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },

        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                },
            },
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    }
})

_ = require("telescope").load_extension "notify"
_ = require("telescope").load_extension "fzf"

local M = {}

function M.search_dotfiles()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "< VimRC >",
        shorten_path = false,
        cwd = "~\\AppData\\Local\\nvim",

        layout_strategy = "flex",
        layout_config = {
            width = 0.9,
            height = 0.8,
            horizontal = {
                width = { padding = 0.15 },
            },
            vertical = {
                preview_height = 0.75,
            },
        },

        mappings = {
            i = {
                ["<C-y>"] = false,
            },
        },

        attach_mappings = function(_, map)
            map("i", "<c-y>", set_prompt_to_entry_value)
            map("i", "<M-c>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                vim.schedule(function()
                    require("telescope.builtin").find_files(opts_without_preview)
                end)
            end)

            return true
        end,
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end

return M
