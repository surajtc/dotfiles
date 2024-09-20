{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      settings = {
        ensureInstalled = [
          "bash"
          "c"
          "diff"
          "lua"
          "luadoc"
          "markdown"
          "markdown_inline"
          "query"
          "vim"
          "vimdoc"
          "python"
          "javascript"
          "typescript"
          "tsx"
          "json"
          "csv"
          "html"
          "css"
          "nix"
        ];

        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };

        indent = {
          enable = true;
          disable = [];
        };
      };
    };
  };
}

