{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/hypr
    ../../home/hyprpanel
    ../../home/anyrun
    ../../home/nvim
    ../../home/stylix
    ../../home/zsh
    ../../home/kitty
    ../../home/tmux
    ../../home/development
  ];

  home.username = "admin";
  home.homeDirectory = "/home/admin";

  home.packages = with pkgs; [
    fastfetch

    chromium
    microsoft-edge

    vscodium-fhs
    slack
    postman

    nautilus
    loupe
    rawtherapee
    file-roller
    p7zip
    unrar
    networkmanagerapplet

    libwebp
    vlc

    usql
    blender
  ];

  programs.firefox.enable = true;

  programs.mpv.enable = true;
  programs.btop.enable = true;

  programs.obs-studio.enable = true;

  programs.git = {
    enable = true;
    userName = "Suraj";
    userEmail = "stelugar@umd.edu";
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
