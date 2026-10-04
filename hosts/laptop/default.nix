{
  pkgs,
  hostVars,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/greeter.nix
    ../../modules/nixos/icons.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/development.nix
  ];

  networking.hostName = hostVars.hostName;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
