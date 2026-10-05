{
  lib,
  pkgs,
  ...
}: let
  tsgoLanguageServers = [
    "typescript-ls"
    "!vtsls"
    "!typescript-language-server"
    "..."
  ];
in {
  home.packages = with pkgs; [
    # Keep Zed's Markdown Oxide LSP on a NixOS-compatible binary instead of
    # letting its extension launch a generic Linux download.
    markdown-oxide
    nixd
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
      "material-icon-theme"
      "live-server"
      "tsgo"
      "github-actions"
      "mdx"
      "sql"
      "env"
    ];

    userSettings = {
      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      base_keymap = "VSCode";
      icon_theme = "Material Icon Theme";

      languages = {
        TypeScript.language_servers = tsgoLanguageServers;
        TSX.language_servers = tsgoLanguageServers;
        JavaScript.language_servers = tsgoLanguageServers;
        JSX.language_servers = tsgoLanguageServers;
      };

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
