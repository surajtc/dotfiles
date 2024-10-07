return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {"lua", "bash", "markdown", "python"},
        auto_install = true,
        highlight = {enabled = true, additional_vim_regex_highlighting = false},
        indent = {enabled = true}
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end
}
