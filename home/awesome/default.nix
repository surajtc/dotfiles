{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    flameshot
    brightnessctl
    bc
  ];

  # xdg.configFile = {
  #   "awesome" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/home/awesome";
  #     # source = "/etc/dotfiles/home/awesome";
  #     recursive = true;
  #   };
  # };

  xdg.configFile = {
    "awesome" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/home/awesome";
      recursive = true;
    };

    # TODO: Find a better way to handle color generation
    "stylix/palette.lua".text = let
      colors = config.lib.stylix.colors.withHashtag;
    in ''
      -- Generated by Stylix
      local palette = {
          base00 = "${colors.base00}",
          base01 = "${colors.base01}",
          base02 = "${colors.base02}",
          base03 = "${colors.base03}",
          base04 = "${colors.base04}",
          base05 = "${colors.base05}",
          base06 = "${colors.base06}",
          base07 = "${colors.base07}",
          base08 = "${colors.base08}",
          base09 = "${colors.base09}",
          base0A = "${colors.base0A}",
          base0B = "${colors.base0B}",
          base0C = "${colors.base0C}",
          base0D = "${colors.base0D}",
          base0E = "${colors.base0E}",
          base0F = "${colors.base0F}",
      }

      return palette
    '';
  };

  # home.file.".config/awesome/theme/colors.lua".text = let
  #   colors = config.lib.stylix.colors.withHashtag;
  # in ''
  #   -- Generated by Stylix
  #   local colors = {
  #       background = "${colors.base00}",
  #       foreground = "${colors.base05}",
  #       primary = "${colors.base0D}",
  #       secondary = "${colors.base0E}",
  #       alert = "${colors.base08}",
  #
  #       base00 = "${colors.base00}",
  #       base01 = "${colors.base01}",
  #       base02 = "${colors.base02}",
  #       base03 = "${colors.base03}",
  #       base04 = "${colors.base04}",
  #       base05 = "${colors.base05}",
  #       base06 = "${colors.base06}",
  #       base07 = "${colors.base07}",
  #       base08 = "${colors.base08}",
  #       base09 = "${colors.base09}",
  #       base0A = "${colors.base0A}",
  #       base0B = "${colors.base0B}",
  #       base0C = "${colors.base0C}",
  #       base0D = "${colors.base0D}",
  #       base0E = "${colors.base0E}",
  #       base0F = "${colors.base0F}",
  #   }
  #
  #   return colors
  # '';

  # home.file = {
  #   ".config/awesome" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "/etc/dotfiles/home/awesome";
  #     recursive = true;
  #   };
  # };

  # home.file.".config/awesome/theme/colors.lua".text = let
  #   colors = config.lib.stylix.colors.withHashtag;
  # in ''
  #   -- Generated by Stylix
  #   local colors = {
  #       background = "${colors.base00}",
  #       foreground = "${colors.base05}",
  #       primary = "${colors.base0D}",
  #       secondary = "${colors.base0E}",
  #       alert = "${colors.base08}",
  #
  #       base00 = "${colors.base00}",
  #       base01 = "${colors.base01}",
  #       base02 = "${colors.base02}",
  #       base03 = "${colors.base03}",
  #       base04 = "${colors.base04}",
  #       base05 = "${colors.base05}",
  #       base06 = "${colors.base06}",
  #       base07 = "${colors.base07}",
  #       base08 = "${colors.base08}",
  #       base09 = "${colors.base09}",
  #       base0A = "${colors.base0A}",
  #       base0B = "${colors.base0B}",
  #       base0C = "${colors.base0C}",
  #       base0D = "${colors.base0D}",
  #       base0E = "${colors.base0E}",
  #       base0F = "${colors.base0F}",
  #   }
  #
  #   return colors
  # '';
}
