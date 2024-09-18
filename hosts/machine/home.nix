{
  config,
  inputs,
  pkgs,
  lib,
  variables,
  ...
}: {
  imports = [
    ../../config/nixvim
    ../../config/hypr
  ];

  home.username = "${variables.userName}";
  home.homeDirectory = "/home/${variables.userName}";

  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    # gcc
    # nodejs
    # pnpm
    # yarn
    # python3
    alejandra
    brave
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    rofi-wayland
    brightnessctl
    gnome-themes-extra
    gtk-engine-murrine
    gtk3
    gtk4
    adwaita-qt
  ];

  home.file = {
    # ".config/nvim" = {
    #     source = ../../config/nvim;
    #     recursive = true;
    #   };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    userName = variables.gitUserName;
    userEmail = variables.gitEmail;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --show-trace --flake .";
    };
  };

  programs.starship.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      shell = "zsh";

      background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base08}";
      # font_size = "11.0";
      # font_falmily = "family=\"JetBrains Mono\"";
      # bold_font = "auto";
      # italic_font = "auto";
      # bold_italic_font = "auto";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  programs.firefox.enable = true;

  programs.home-manager.enable = true;

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
    image = ../../config/wallpapers/default.png;
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
