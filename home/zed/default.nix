{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "git-firefly"
      "dockerfile"
      "docker-compose"
      "markdown-oxide"
      "toml"
      "csv"
      "react-typescript-snippets"
      "biome"
    ];
    userSettings = {
      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      base_keymap = "VSCode";

      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = lib.mkForce 12.6;

      theme = "Base16 Classic Dark";

      ui_font_family = "Inter";
      ui_font_size = 12.0;

      format_on_save = "off";

      tabs = {
        file_icons = true;
        git_status = true;
      };

      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      terminal = {
        shell = {program = "zsh";};
      };
    };
  };
}
