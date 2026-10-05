{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig."51-bluez-no-hardware-volume" = {
        "monitor.bluez.properties"."bluez5.enable-hw-volume" = false;
      };
    };
  };

  security.rtkit.enable = true;
}
