{config, pkgs, inputs, userVars, ...}: {
  imports = [
    ../../modules/home-manager/common.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/desktop/niri.nix
    ../../modules/home-manager/desktop/nsticky.nix
    ../../modules/home-manager/desktop/noctalia.nix
    ../../modules/home-manager/desktop/wayland.nix
    ../../modules/home-manager/desktop/theme.nix
    ../../modules/home-manager/programs/shell.nix
    ../../modules/home-manager/programs/fastfetch.nix
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/agents.nix
    ../../modules/home-manager/programs/kitty.nix
    ../../modules/home-manager/programs/neovim.nix
    ../../modules/home-manager/programs/tmux.nix
    inputs.stylix.homeModules.stylix
    inputs.niri.homeModules.stylix
    inputs.noctalia.homeModules.default
    inputs.nsticky.homeModules.default
  ];

  home.username = userVars.username;
  home.homeDirectory = userVars.homeDirectory;
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
