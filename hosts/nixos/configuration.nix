{
  config,
  lib,
  pkgs,
  inputs,
  vars,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    kernelParams = ["i915.force_probe=46a6"];
    extraModprobeConfig = ''
      options iwlwifi power_save=1 disable_11ax=1
    '';
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix".options = ["compress=zstd" "noatime"];
    # TODO: Set options for swap
  };

  # TODO: Enable swap to file using btrfs
  # swapDevices = [ { device = "/swap/swapfile"; } ];

  networking = {
    hostName = vars.hostName;
    networkmanager = {
      enable = true;
      plugins = [pkgs.networkmanager-openconnect];
    };
  };

  time.timeZone = vars.timeZone;

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
    libinput.touchpad.naturalScrolling = true;
    xserver = {
      enable = true;

      excludePackages = [pkgs.xterm];

      xkb.layout = "us";

      displayManager.lightdm = {
        enable = true;
        extraConfig = ''
          display-setup-script=${pkgs.autorandr}/bin/autorandr --change
        '';
      };

      dpi = 96;

      displayManager.sessionCommands = ''
        xset s off
        xset -dpms
        xset s noblank
      '';

      displayManager.setupCommands = ''
        ${pkgs.autorandr}/bin/autorandr --change
      '';

      # desktopManager.xfce.enable = true;

      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-luajit-git;
        luaModules = with pkgs; [
          luajitPackages.lgi
        ];
      };

      videoDrivers = ["nvidia"];
    };

    displayManager.defaultSession = "none+awesome";

    picom = {
      enable = true;
      backend = "glx";
    };

    autorandr = {
      enable = true;
      defaultTarget = "laptop";
      profiles = {
        "laptop" = {
          fingerprint = {
            eDP-1 = "00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "1920x1200";
              position = "0x0";
              rate = "59.95";
            };
          };
        };
        "dock" = {
          fingerprint = {
            DP-3 = "00ffffffffffff001c5418270101010116200104b53c2278fb8cb5af4f43ab260e50543fcf0081809500b300d1c0714f81c081400101565e00a0a0a029503020350055502100001a000000fd0c30a505055a010a202020202020000000fc004d32375120500a202020202020000000ff003232323233423030303037380a02ae02032ef1480313042f1f10403f23090707830100006d1a0000020130a5000000000000e305c000e606070160574f09ec00a0a0a067503020350055502100001a6fc200a0a0a055503020350055502100001a5a8780a070384d403020350055502100001a0000000000000000000000000000000000000000000000000000003770127903000301143d110104ff099f002f801f009f0576000200040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007290";
            eDP-1 = "00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1";
          };
          config = {
            DP-3 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              position = "0x0";
              rate = "59.95";
            };

            eDP-1 = {
              enable = true;
              mode = "1920x1200";
              position = "2560x0";
              rate = "59.95";
            };
          };
        };
        "laptop-gpu" = {
          fingerprint = {
            eDP-1-1 = "00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1";
          };
          config = {
            eDP-1-1 = {
              enable = true;
              mode = "1920x1200";
              position = "0x0";
              rate = "59.95";
            };
          };
        };
        "dock-gpu" = {
          fingerprint = {
            DP-1-3 = "00ffffffffffff001c5418270101010116200104b53c2278fb8cb5af4f43ab260e50543fcf0081809500b300d1c0714f81c081400101565e00a0a0a029503020350055502100001a000000fd0c30a505055a010a202020202020000000fc004d32375120500a202020202020000000ff003232323233423030303037380a02ae02032ef1480313042f1f10403f23090707830100006d1a0000020130a5000000000000e305c000e606070160574f09ec00a0a0a067503020350055502100001a6fc200a0a0a055503020350055502100001a5a8780a070384d403020350055502100001a0000000000000000000000000000000000000000000000000000003770127903000301143d110104ff099f002f801f009f0576000200040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007290";
            eDP-1-1 = "00ffffffffffff004d101515000000000d1f0104a52215780ede50a3544c99260f505400000001010101010101010101010101010101283c80a070b023403020360050d210000018203080a070b023403020360050d210000018000000fe00445737584e814c513135364e31000000000002410332001200000a010a202000d1";
          };
          config = {
            DP-1-3 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              position = "0x0";
              rate = "59.95";
            };

            eDP-1-1 = {
              enable = true;
              mode = "1920x1200";
              position = "2560x0";
              rate = "59.95";
            };
          };
        };
      };
    };

    udev.extraRules = ''ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    blueman.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    smartd.enable = true;

    upower.enable = true;
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

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        sync.enable = true;

        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  powerManagement.enable = false;
  virtualisation.docker.enable = true;
  virtualisation.containers.enable = true;
  # virtualisation.podman.enable = true;
  # virtualisation.podman.dockerCompat = true;
  # virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  users.users.${vars.userName} = {
    isNormalUser = true;
    description = vars.userName;
    extraGroups = ["networkmanager" "wheel" "docker"];
    # TODO: Fix shell
    # shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    efibootmgr
    psmisc
    wget
    curl
    git
    tree

    fzf
    ripgrep
    zip
    unzip
    gnutar
    xz

    kitty

    networkmanager-openconnect
    webkitgtk

    rsbkb
    xmlstarlet
    inetutils
    hostname
    openconnect
    openssl

    fastfetch
    alejandra
    luajit
    luajitPackages.lgi
    luajitPackages.luarocks
    (luajit.withPackages (ps: with ps; [lgi]))

    # (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})

    volumeicon
    pavucontrol
    playerctl
    networkmanagerapplet

    dconf
    xarchiver

    # xfce.thunar
    # xfce.thunar-archive-plugin
    # xfce.thunar-volman
    # xfce.thunar-media-tags-plugin
    xarchiver

    gnome-themes-extra
    gtk-engine-murrine
    gtk3
    gtk4
    adwaita-qt

    # podman
    dive
    podman-tui
    docker-compose
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };
  programs.xfconf.enable = true;

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   vimAlias = true;
  #   viAlias = true;
  # };

  environment.variables = {
    LUA_PATH = "${pkgs.luajitPackages.lgi}/share/lua/5.1/?.lua;${pkgs.luajitPackages.lgi}/share/lua/5.1/?/init.lua";
    LUA_CPATH = "${pkgs.luajitPackages.lgi}/lib/lua/5.1/?.so";
  };

  environment.etc."openconnect/csd-post.sh" = {
    mode = "0755";
    text = builtins.readFile ../../home/vpn/csd-post.sh;
  };

  environment.etc."openconnect/openssl.conf" = {
    text = builtins.readFile ../../home/vpn/openssl.conf;
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
