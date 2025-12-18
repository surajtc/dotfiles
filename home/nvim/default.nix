{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      vim-tmux-navigator

      mini-base16
      mini-icons

      snacks-nvim

      {
        plugin = copilot-lua;
        config = builtins.readFile config/plugins/copilot.lua;
        type = "lua";
      }

      copilot-lualine
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
        plugin = oil-nvim;
        config = builtins.readFile config/plugins/oil.lua;
        type = "lua";
      }

      friendly-snippets
      blink-cmp
      typescript-tools-nvim
      nvim-ts-autotag
      blink-copilot
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile config/plugins/nvim-lspconfig.lua;
        type = "lua";
      }

      {
        plugin = conform-nvim;
        config = builtins.readFile config/plugins/conform.lua;
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
      ${builtins.readFile config/debug.lua}
      ${builtins.readFile config/plugins/snacks.lua}
    '';

    extraPackages = with pkgs; [
      gcc
      ripgrep
      fzf

      stylua
      lua-language-server

      # black
      # isort
      nodejs
      nodePackages.prettier
      prettierd
      # nodePackages.typescript-language-server
      tailwindcss-language-server
      biome

      astro-language-server

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
