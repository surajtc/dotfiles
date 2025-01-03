{
  config,
  inputs,
  pkgs,
  lib,
  vars,
  ...
}: {
  imports = [
    ../../home/awesome
    ../../home/nvim
    ../../home/tmux
    ../../home/firefox
    ../../home/ranger
    ../../home/rofi
  ];

  home.username = "${vars.userName}";
  home.homeDirectory = "/home/${vars.userName}";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    slack
    zoom-us
    microsoft-edge
    vlc
    flameshot
    brightnessctl
    bc
    gcc

    xdotool

    geeqie
    zathura

    remmina
    pgadmin4-desktopmode

    sass

    # TODO: Move this to devShells
    # python3
    (python3.withPackages (ps:
      with ps; [
        uv
        pip
        jupyter
        ipython
        numpy
        pandas
        tqdm
        requests
        scikit-learn
        matplotlib
        seaborn
        plotly
        pillow
        beautifulsoup4
        black
        mypy
      ]))

    nodejs
    pnpm
    yarn
    cypress

    libgccjit
    fzf
    xclip
    xsel
    fd

    # glib
    # gtk3
    # libnotify
    # nss
    # alsa-lib
    # xorg.libXScrnSaver
    # xorg.libXtst
    # xorg.libxcb

    steam-run
    noto-fonts
    # (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    nerd-fonts.symbols-only

    postman
  ];

  home.sessionVariables = {
    EDITOR = "nvim";

    CM_LAUNCHER = "rofi";

    CYPRESS_INSTALL_BINARY = 0;
    CYPRESS_RUN_BINARY = "${pkgs.cypress}/bin/Cypress";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = vars.gitUserName;
    userEmail = vars.gitEmail;
  };

  programs.chromium.enable = true;
  programs.firefox.enable = true;

  programs.mpv.enable = true;
  programs.btop.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    history.ignoreAllDups = true;
    history.ignoreSpace = true;
    historySubstringSearch.enable = true;

    defaultKeymap = "emacs";

    cdpath = ["$HOME/Documents" "$HOME/Documents/CodeBase"];

    shellAliases = {
      c = "clear";
      ll = "ls -la";
      ee = "tree -L 3";

      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";
      gs = "git status";

      nixedit = "cd /etc/dotfiles && nvim";
      nixrebuild = "sudo nixos-rebuild switch --show-trace --flake .";

      cattlabvpn = "sudo OPENSSL_CONF=/etc/openconnect/openssl.conf openconnect --user=stelugar --csd-wrapper=/etc/openconnect/csd-post.sh vpn.cattlab.umd.edu";
    };

    initExtra = "fastfetch";
  };

  programs.starship.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      enable_audio_bell = "no";
      shell = "zsh";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    userSettings = {
      "workbench.sideBar.location" = "right";
      "editor.cursorStyle" = "block";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "window.menuBarVisibility" = "toggle";
      "workbench.startupEditor" = "none";
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };

    extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-toolsai.jupyter
      dbaeumer.vscode-eslint
      zainchen.json
      ritwickdey.liveserver
      ms-azuretools.vscode-docker
      eamodio.gitlens
      esbenp.prettier-vscode
      formulahendry.auto-rename-tag
      formulahendry.auto-close-tag
      formulahendry.code-runner
      ms-vscode-remote.remote-ssh
      christian-kohler.path-intellisense
      yzhang.markdown-all-in-one
      bbenoist.nix
      kamadorueda.alejandra
    ];
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      # wlrobs
      # obs-backgroundremoval
      obs-pipewire-audio-capture
      input-overlay
    ];
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    fade = true;
    fadeDelta = 5;
    fadeSteps = [0.03 0.03];

    shadow = false;

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;

    settings = {
      # shadow = false;
      # detect-rounded-corners = true;
      # detect-client-opacity = true;
      # detect-transient = true;
      # transparent-clipping = true;

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      glx-no-stencil = true;
      use-damage = true;

      corner-radius = 4;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];

      blur-background = false;
      blur-background-frame = false;
      blur-background-fixed = false;

      blur = {
        method = "gaussian";
        size = 10;
        deviation = 5.0;
      };

      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      wintypes = {
        tooltip = {
          fade = true;
          shadow = false;
          blur-background = false;
          opacity = 1.0;
        };
        dock = {
          shadow = false;
          blur-background = false;
          clip-shadow-above = true;
        };
        dnd = {
          opacity = 1.0;
          shadow = false;
          blur-background = false;
        };
        popup_menu = {
          opacity = 1.0;
          shadow = false;
          blur-background = false;
        };
        dropdown_menu = {
          opacity = 1.0;
          shadow = false;
          blur-background = false;
        };
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita";
    platformTheme.name = "gtk";
  };

  stylix = {
    enable = true;
    image = ../../home/wallpapers/default.svg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";

    cursor.size = 24;

    fonts = {
      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 10;
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        # package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      neovim.transparentBackground = {
        main = true;
        signColumn = true;
      };
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Noto Serif" "Symbols Nerd Font"];
      sansSerif = ["Inter" "Symbols Nerd Font"];
      monospace = ["JetBrainsMono Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };

  xdg.enable = true;
}
