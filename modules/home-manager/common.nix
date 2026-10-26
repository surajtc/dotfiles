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
      "video/mp4" = ["mpv.desktop" "vlc.desktop"];
      "video/mp4v-es" = ["mpv.desktop" "vlc.desktop"];
      "video/mpeg" = ["mpv.desktop" "vlc.desktop"];
      "video/mp2t" = ["mpv.desktop" "vlc.desktop"];
      "video/ogg" = ["mpv.desktop" "vlc.desktop"];
      "video/quicktime" = ["mpv.desktop" "vlc.desktop"];
      "video/webm" = ["mpv.desktop" "vlc.desktop"];
      "video/avi" = ["mpv.desktop" "vlc.desktop"];
      "video/divx" = ["mpv.desktop" "vlc.desktop"];
      "video/dv" = ["mpv.desktop" "vlc.desktop"];
      "video/fli" = ["mpv.desktop" "vlc.desktop"];
      "video/flv" = ["mpv.desktop" "vlc.desktop"];
      "video/mkv" = ["mpv.desktop" "vlc.desktop"];
      "video/msvideo" = ["mpv.desktop" "vlc.desktop"];
      "video/vnd.avi" = ["mpv.desktop" "vlc.desktop"];
      "video/vnd.divx" = ["mpv.desktop" "vlc.desktop"];
      "video/vnd.mpegurl" = ["mpv.desktop" "vlc.desktop"];
      "video/vnd.rn-realvideo" = ["mpv.desktop" "vlc.desktop"];
      "video/x-matroska" = ["mpv.desktop" "vlc.desktop"];
      "video/x-avi" = ["mpv.desktop" "vlc.desktop"];
      "video/x-flc" = ["mpv.desktop" "vlc.desktop"];
      "video/x-flic" = ["mpv.desktop" "vlc.desktop"];
      "video/x-msvideo" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-wmv" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-asf" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-afs" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-wmx" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ms-wvxvideo" = ["mpv.desktop" "vlc.desktop"];
      "video/x-mpeg2" = ["mpv.desktop" "vlc.desktop"];
      "video/x-mpeg3" = ["mpv.desktop" "vlc.desktop"];
      "video/x-m4v" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ogm" = ["mpv.desktop" "vlc.desktop"];
      "video/x-ogm+ogg" = ["mpv.desktop" "vlc.desktop"];
      "video/x-theora" = ["mpv.desktop" "vlc.desktop"];
      "video/x-theora+ogg" = ["mpv.desktop" "vlc.desktop"];
      "video/x-flv" = ["mpv.desktop" "vlc.desktop"];
      "video/3gpp" = ["mpv.desktop" "vlc.desktop"];
      "video/3gpp2" = ["mpv.desktop" "vlc.desktop"];
      "video/3gp" = ["mpv.desktop" "vlc.desktop"];
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
    mpv
    vlc
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
