{...}: {
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # The development environment itself lives in /etc/dotfiles/dev.
  # This small pointer makes every project below CodeBase use that flake.
  home.file."Documents/CodeBase/.envrc".text = ''
    use flake /etc/dotfiles/dev
  '';
}
