{pkgs, ...}: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["org.gnome.Nautilus.desktop"];
      "application/zip" = ["org.gnome.FileRoller.desktop"];
      "application/x-tar" = ["org.gnome.FileRoller.desktop"];
      "application/gzip" = ["org.gnome.FileRoller.desktop"];
      "application/x-bzip2" = ["org.gnome.FileRoller.desktop"];
      "application/x-xz" = ["org.gnome.FileRoller.desktop"];
      "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
      "application/vnd.rar" = ["org.gnome.FileRoller.desktop"];
      "application/x-rar-compressed" = ["org.gnome.FileRoller.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      "x-scheme-handler/http" = ["brave-browser.desktop"];
      "x-scheme-handler/https" = ["brave-browser.desktop"];
      "text/html" = ["brave-browser.desktop"];
    };
  };

  # This file may already exist from a previous Noctalia/desktop-settings
  # change. The declarative MIME defaults above are now the source of truth.
  xdg.configFile."mimeapps.list".force = true;
  xdg.dataFile."applications/mimeapps.list".force = true;

  home.packages = with pkgs; [
    brave
    fastfetch
    btop
    ripgrep
    fd
    fzf
    jq
    tree
    curl
    wget
    wdisplays
    pwvucontrol
    qpwgraph
    wl-clipboard
    ccusage
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
  };
}
