{pkgs, ...}: {
  # services.clipmenu = {
  #   enable = true;
  #   launcher = "rofi";
  # };

  services.copyq.enable = true;

  programs.rofi = {
    enable = true;
  };
}
