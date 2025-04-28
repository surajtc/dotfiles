{pkgs, ...}: {
  stylix = {
    enable = true;
    # image = ../wallpapers/default.svg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 24;
    };

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

      firefox.profileNames = ["default"];
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
}
