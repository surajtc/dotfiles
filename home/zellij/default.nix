{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;

    settings = {
      default_shell = "zsh";
      pane_frames = false;
      simplified_ui = true;
      # default_layout = "compact";
    };
  };
}
