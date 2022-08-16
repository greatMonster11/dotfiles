require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "go",
        "html",
        "javascript",
        "json",
        "markdown",
        "python",
        "rust",
        "lua",
        "vim",
        "tsx",
        "typescript",
    },

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
