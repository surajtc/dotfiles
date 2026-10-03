{inputs, pkgs, ...}: let
  telaCircleIcons = pkgs.callPackage ../../packages/tela-circle-icon-theme.nix {
    src = inputs.tela-circle-icons;
  };
in {
  # Make the theme available from the system profile as well as Home Manager,
  # so display-manager and greeter processes can resolve it before login.
  environment.systemPackages = [telaCircleIcons];

}
