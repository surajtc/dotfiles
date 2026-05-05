{
  pkgs,
  lib,
  ...
}: {
  programs.opencode = {
    enable = true;
  };

  programs.codex = {
    enable = true;
  };

  programs.claude-code = {
    enable = true;
  };
}
