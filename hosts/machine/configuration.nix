{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = ["i915.force_probe=46a6" "quiet" "udev.log_level=3"];
    supportedFilesystems = ["ntfs"];
    extraModprobeConfig = ''
      options iwlwifi power_save=1 disable_11ax=1
    '';
  };

  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.enable = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    devices = ["nodev"];
    default = "saved";
    useOSProber = true;
  };

  # Networking
  networking.hostName = "machine";
  # networking.wireless.enable = true;  # To enable wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = "loose";

  # networking.extraHosts = ''
  #   0.0.0.0 apresolve.spotify.com
  # '';

  # System
  # time.timeZone = "America/New_York";
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Display manager
  # services.displayManager.ly = {
  #   enable = true;
  # settings = {
  #   save = true;
  #   load = true;
  # };
  # };

  # environment.loginShellInit = ''
  #   if uwsm check may-start && uwsm select; then
  #   	exec uwsm start default
  #   fi
  # '';

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
  };

  # Window manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  # programs.uwsm.enable = true;
  programs.dms-shell = {
    enable = true;
    systemd.enable = true;
    enableDynamicTheming = false;
  };

  security.pam.services.hyprlock = {};

  # Extra services
  services.printing.enable = true;
  services.blueman.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.smartd.enable = true;

  services.upower.enable = true;
  services.tuned.enable = true;
  services.thermald.enable = true;
  # services.power-profiles-daemon.enable = true;
  # services.tlp = {
  #   enable = false;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #
  #     CPU_MIN_PERF_ON_AC = 0;
  #     CPU_MAX_PERF_ON_AC = 100;
  #     CPU_MIN_PERF_ON_BAT = 0;
  #     CPU_MAX_PERF_ON_BAT = 20;
  #
  #     START_CHARGE_THRESH_BAT0 = 40;
  #     STOP_CHARGE_THRESH_BAT0 = 80;
  #   };
  # };

  # Hardware
  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-vaapi-driver
      intel-media-driver
    ];
  };

  # Nvidia
  # disable nvidia
  # services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  #   ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  # '';

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # To test if prime is working use the following
    # cat /sys/module/nvidia_drm/parameters/modeset
    # Should output "Y"
    # __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia glxinfo -B | grep "OpenGL renderer"
    # NVIDIA GPU should show NVIDIA
    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.containers.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  programs.dconf.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    git
    lazygit
    btop
    fastfetch
    nvtopPackages.nvidia
    mesa-demos

    tldr
    busybox
    lazydocker
    steam-run-free

    ntfs3g

    # neovim
    # kitty
    # greetd.tuigreet
    efibootmgr
    bash

    gnome-themes-extra
    gtk-engine-murrine
    gtk3
    gtk4
    adwaita-qt
    wireguard-tools
  ];

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  environment.localBinInPath = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
