{
  pkgs,
  lib,
  ...
}: {
  home.file = {
    ".config/uwsm/env" = {
      text = ''
        export MOZ_ENABLE_WAYLAND=1
        export GDK_BACKEND=wayland
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland
        export QT_QPA_PLATFORM=wayland
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export NIXOS_OZONE_WL=1
        export ELECTRON_OZONE_PLATFORM_HINT=auto
      '';
    };
  };
}
