{pkgs, ...}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gnome xdg-desktop-portal-gtk];
    config.niri."org.freedesktop.impl.portal.FileChooser" = ["gnome"];
  };

  environment.systemPackages = with pkgs; [
    nautilus
    file-roller
    sushi
    loupe
    zip
    unzip
    p7zip
    unrar
    ffmpegthumbnailer
  ];

  services.gnome.gnome-keyring.enable = true;

  # Hardware services used by the laptop desktop. Noctalia provides the UI;
  # these services provide the underlying Bluetooth, battery, and power APIs.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.thermald.enable = true;

  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };
  };
}
