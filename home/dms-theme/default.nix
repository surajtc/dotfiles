{
  pkgs,
  config,
  inputs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  home.file.".config/DankMaterialShell/stylix-theme.json".text = builtins.toJSON {
    name = "Stylix";
    primary = colors.base0D;
    primaryText = colors.base00;
    primaryContainer = colors.base0C;
    secondary = colors.base0E;
    surface = colors.base01;
    surfaceText = colors.base05;
    surfaceVariant = colors.base02;
    surfaceVariantText = colors.base06;
    surfaceTint = colors.base0D;
    background = colors.base00;
    backgroundText = colors.base05;
    outline = colors.base03;
    surfaceContainer = colors.base01;
    surfaceContainerHigh = colors.base02;
    surfaceContainerHighest = colors.base03;
    error = colors.base08;
    warning = colors.base0A;
    info = colors.base0D;
    matugen_type = "scheme-tonal-spot";
  };
  home.file.".local/state/DankMaterialShell/session.json".text = builtins.toJSON {
    wallpaperPath = colors.base00;
  };
}
