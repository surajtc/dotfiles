{
  config,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ../../home/uwsm
    ../../home/niri
    # ../../home/hypr
    ../../home/dms-theme
    ../../home/fuzzel
    ../../home/nvim
    ../../home/zed
    ../../home/stylix
    ../../home/zsh
    ../../home/kitty
    ../../home/tmux
    # ../../home/spotify-player
    # ../../home/spotifyd
  ];

  home.username = vars.userName;
  home.homeDirectory = "/home/${vars.userName}";

  home.packages = with pkgs; [
    fastfetch

    # chromium
    brave
    google-chrome

    vscode-fhs
    code-cursor-fhs
    # slack
    # discord-canary

    nautilus
    loupe
    rawtherapee
    file-roller
    p7zip
    unrar
    networkmanagerapplet

    # libwebp
    vlc

    usql
    ffmpeg
    spotify
    yt-dlp
    svix-cli
    delfin
    jellyfin-media-player
  ];

  programs.firefox.enable = true;

  # programs.firefox.profiles.default = {
  #   id = 0;
  #   name = "default";
  #   isDefault = true;
  # };

  programs.mpv.enable = true;
  programs.btop.enable = true;

  programs.obs-studio.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings.user.name = vars.gitUser;
    settings.user.email = vars.gitEmail;
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
