{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pyright
    rust-analyzer
    gopls
  ];

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
      buffer_font_size = lib.mkForce 13.0;

      ui_font_family = "SFProDisplay Nerd Font";
      ui_font_size = lib.mkForce 15.0;

      # Let Niri/compositor handle window decorations instead of Zed's
      # client-side title bar and rounded window frame.
      window_decorations = "server";

      project_panel.dock = "left";
      collaboration_panel.button = false;
      agent.dock = "right";
      agent.sidebar_side = "right";
      terminal.dock = "right";
      git_panel.dock = "left";
      debugger.dock = "right";
      outline_panel.dock = "left";

      format_on_save = "off";

      tabs = {
        file_icons = true;
        git_status = true;
      };

      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };

      terminal.shell = {
        program = "zsh";
      };
    };
  };
}
