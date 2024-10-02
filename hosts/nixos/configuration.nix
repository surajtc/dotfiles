{
  config,
  lib,
  pkgs,
  inputs,
  variables,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelParams = ["i915.force_probe=46a6"];

  boot.extraModprobeConfig = ''
    options iwlwifi power_save=1 disable_11ax=1
  '';

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

  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd awesome";
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

    thermald.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio.enable = false;

    cpu.intel.updateMicrocode = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vpl-gpu-rt
      ];
    };
  };

  powerManagement.enable = true;

  virtualisation.docker.enable = true;

  users.users.${variables.userName} = {
    isNormalUser = true;
    description = variables.userName;
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

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
    ];
  };

  programs.zsh.enable = true;

  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05";
}
