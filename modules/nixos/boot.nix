{...}: {
  # Keep the early boot path quiet while retaining normal logs in journald.
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.udev.log_level=3"
    "rd.systemd.show_status=auto"
  ];

  # Skip the systemd-boot menu during normal boots. Hold a key while booting
  # to access the boot menu and previous generations for recovery.
  boot.loader.timeout = 0;
}
