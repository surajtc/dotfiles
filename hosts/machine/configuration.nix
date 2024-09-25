{
  config,
  pkgs,
  inputs,
  variables,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    # systemd-boot.enable = true;

    grub.enable = true;
    grub.efiSupport = true;
    grub.devices = ["nodev"];
    # grub.device = "/dev/nvme1n1p3";
    grub.useOSProber = true;
    grub.default = "saved";

    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = variables.hostName;
    networkmanager.enable = true;
  };

  time.timeZone = variables.timeZone;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = variables.userName;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    blueman.enable = true;
    upower.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    ollama.enable = true;
    jellyfin.enable = true;
    jellyfin.openFirewall = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio.enable = false;
    graphics.enable = true;
  };

  virtualisation.docker.enable = true;

  users.users.${variables.userName} = {
    isNormalUser = true;
    description = variables.userName;
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  fonts.packages = with pkgs; [
    terminus_font
  ];

  environment = {
    pathsToLink = ["/share/zsh"];
    systemPackages = with pkgs; [
      killall
      greetd.tuigreet
      git
      curl
      wget
      tree
      fastfetch
      fzf
      ripgrep
      zip
      unzip
      gnutar
      xz
      xdg-user-dirs
      dconf
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };

  programs.zsh.enable = true;

  security.polkit.enable = true;

  security.pam.services.hyprlock = {};

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05";
}
