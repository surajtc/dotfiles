{
  config,
  inputs,
  pkgs,
  lib,
  vars,
  ...
}: {
  imports = [
    # ../../config/firefox
    ../../home/nvim
    ../../home/tmux
  ];

  home.username = "${vars.userName}";
  home.homeDirectory = "/home/${vars.userName}";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    stow
    slack
    zoom-us
    microsoft-edge
    vlc
    flameshot

    xdotool

    # TODO: Move this to devShells
    python3
    nodejs
    pnpm
    yarn

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
  ];

  home.file = {
    # ".config/nvim" = {
    #     source = ../../home/nvim;
    #     recursive = true;
    #   };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
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

    defaultKeymap = "emacs";

    cdpath = ["$HOME/Documents" "$HOME/Documents/CodeBase"];

    shellAliases = {
      ll = "ls -la";
      ee = "tree -L 3";

      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";

      nixedit = "cd /etc/dotfiles && nvim";
      nixrebuild = "sudo nixos-rebuild switch --show-trace --flake .";

      cy = "steam-run npx cypress open --env configFile=";

      cattlabvpn = "sudo OPENSSL_CONF=/etc/openconnect/openssl.conf openconnect --user=stelugar --csd-wrapper=/etc/openconnect/csd-post.sh vpn.cattlab.umd.edu";
    };

    initExtra = "fastfetch";
  };

  programs.starship.enable = true;

  # programs.neovim = {
  # enable = true;
  # defaultEditor = true;
  # viAlias = true;
  # vimAlias = true;
  # };

  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      enable_audio_bell = "no";
      shell = "zsh";

      # background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base08}";
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

  xsession.initExtra = ''
    xset s off
    xset -dpms
    xset s noblank
  '';
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    settings = {
      shadow = false;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      transparent-clipping = true;
      corner-radius = 4;
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor.size = 24;

    fonts = {
      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 10;
      };

      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
