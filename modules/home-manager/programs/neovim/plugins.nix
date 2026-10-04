{pkgs, ...}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nvim-treesitter.withAllGrammars
    vim-tmux-navigator

    mini-base16
    mini-icons
    mini-diff
    snacks-nvim

    {
      plugin = lualine-nvim;
      config = builtins.readFile ./lua/plugins/lualine.lua;
      type = "lua";
    }

    plenary-nvim
    telescope-fzf-native-nvim
    telescope-ui-select-nvim
    {
      plugin = telescope-nvim;
      config = builtins.readFile ./lua/plugins/telescope.lua;
      type = "lua";
    }

    {
      plugin = oil-nvim;
      config = builtins.readFile ./lua/plugins/oil.lua;
      type = "lua";
    }

    {
      plugin = neo-tree-nvim;
      config = builtins.readFile ./lua/plugins/neo-tree.lua;
      type = "lua";
    }

    friendly-snippets
    blink-cmp
    typescript-tools-nvim
    nvim-ts-autotag
    {
      plugin = nvim-lspconfig;
      config = builtins.readFile ./lua/plugins/nvim-lspconfig.lua;
      type = "lua";
    }

    {
      plugin = conform-nvim;
      config = builtins.readFile ./lua/plugins/conform.lua;
      type = "lua";
    }

    {
      plugin = arrow-nvim;
      config = builtins.readFile ./lua/plugins/arrow.lua;
      type = "lua";
    }

    {
      plugin = nvim-highlight-colors;
      config = ''
        require('nvim-highlight-colors').setup({})
        ${builtins.readFile ./lua/plugins/highlights.lua}
      '';
      type = "lua";
    }
  ];
}
