{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars

      {
        plugin = nvim-web-devicons;
        config = ''
          require("nvim-web-devicons").setup({})
        '';
        type = "lua";
      }

      {
        plugin = lualine-nvim;
        config = builtins.readFile config/plugins/lualine.lua;
        type = "lua";
      }

      plenary-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      {
        plugin = telescope-nvim;
        config = builtins.readFile config/plugins/telescope.lua;
        type = "lua";
      }

      {
        plugin = neo-tree-nvim;
        config = builtins.readFile config/plugins/neo-tree.lua;
        type = "lua";
      }

      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      friendly-snippets
      nvim-lspconfig
      {
        plugin = lsp-zero-nvim;
        config = builtins.readFile config/plugins/lsp-zero.lua;
        type = "lua";
      }

      {
        plugin = conform-nvim;
        config = builtins.readFile config/plugins/conform.lua;
        type = "lua";
      }

      {
        plugin = indent-blankline-nvim;
        config = builtins.readFile config/plugins/indent-blankline.lua;
        type = "lua";
      }

      {
        plugin = arrow-nvim;
        config = builtins.readFile config/plugins/arrow.lua;
        type = "lua";
      }

      {
        plugin = nvim-highlight-colors;
        config = ''
          require('nvim-highlight-colors').setup({})
        '';
        type = "lua";
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile config/options.lua}
      ${builtins.readFile config/mappings.lua}
    '';

    extraPackages = with pkgs; [
      gcc

      stylua
      lua-language-server

      # black
      # isort

      nodePackages.prettier
      prettierd
      nodePackages.typescript-language-server
      tailwindcss-language-server

      alejandra

      pyright

      (python3.withPackages (ps:
        with ps; [
          # python-lsp-server
          # python-lsp-jsonrpc
          # python-lsp-black
          # python-lsp-ruff
          # pyls-isort
          # pyls-flake8
          # flake8
          isort
          black
        ]))
    ];
  };
}
