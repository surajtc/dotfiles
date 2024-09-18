{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/lualine.nix
    ./plugins/mini.nix
    ./plugins/nvim-cmp.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/which-key.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    vimAlias = true;
    vimdiffAlias = true;

    globals = {
      # set <leader>
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;

      # disable netrw
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };

    opts = {
      # set number
      number = true;
      relativenumber = true;

      # enable mouse
      mouse = "a";

      # hide mode
      showmode = false;

      # sync clipboard between OS and Neovim
      clipboard = {
        providers = {
          wl-copy.enable = true;
        };

        register = "unnamedplus";
      };

      breakindent = true;

      undofile = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";

      # Decrease update time
      updatetime = 250;

      # Decrease mapped sequence wait time
      # Displays which-key popup sooner
      timeoutlen = 300;

      splitright = true;
      splitbelow = true;

      list = true;
      listchars.__raw = "{ tab = '⊣ ', trail = '∙', nbsp = '␣', multispace = '∙' }";

      # guicursor = "{ 'n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon0-blinkoff0', 'i-ci:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100', 'r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100' }";

      inccommand = "split";

      cursorline = true;

      scrolloff = 4;

      hlsearch = true;

      # remove ~ in end of buffer
      fillchars = "eob: ";

      termguicolors = true;

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      smartindent = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
      }
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }
    ];

    autoGroups = {
      nvim-highlight-yank = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = ["TextYankPost"];
        desc = "Highlight when yanking (copying) text";
        group = "nvim-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

    plugins = {
      sleuth = {
        enable = true;
      };

      todo-comments = {
        enable = true;
        signs = true;
      };
    };
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons # TODO: Figure out how to configure using this with telescope
    ];

    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end
    '';

    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2 sw=2 et
    '';
  };
}
