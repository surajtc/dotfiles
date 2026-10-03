{config, pkgs, inputs, ...}: let
  telaCircleIcons = pkgs.callPackage ../../../packages/tela-circle-icon-theme.nix {
    src = inputs.tela-circle-icons;
  };
in {
  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
    icons = {
      enable = true;
      package = telaCircleIcons;
      dark = "Tela-circle-dark";
      light = "Tela-circle-light";
    };
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
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    targets.kde.enable = false;
    targets.niri.enable = true;
    targets.noctalia.enable = true;
  };

  programs.niri.settings.layout.background-color =
    config.lib.stylix.colors.withHashtag.base00;
}
