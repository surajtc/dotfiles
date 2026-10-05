{pkgs, ...}: {
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    pciutils
    lm_sensors
  ];
}
