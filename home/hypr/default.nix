{
  pkgs,
  inputs,
  ...
}: {
  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   config = {
  #     common.default = ["gtk"];
  #     hyprland.default = ["gtk" "hyprland"];
  #   };
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #     pkgs.xdg-desktop-portal-hyprland
  #   ];
  # };

  home.packages = with pkgs; [
    playerctl
    pwvucontrol
    brightnessctl

    slurp
    grim

    wl-clipboard
  ];

  programs.hyprlock.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;

    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
        resize_on_border = false;
      };

      decoration = {
        rounding = 4;
        active_opacity = 1;
        inactive_opacity = 1;

        # drop_shadow = false;

        blur = {
          enabled = false;
          size = 4;
          passes = 2;
          vibrancy = 0.2;
        };
      };

      animations = {
        first_launch_animation = false;
        enabled = false;
      };

      exec-once = [
        "${pkgs.hyprpanel}/bin/hyprpanel"
        "nm-applet &"
      ];

      env = [
        "MOZ_ENABLE_WAYLAND,1"
        "GDK_BACKEND,wayland"
        "QT_QPA_PLATFORM,wayland"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"

        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        # "LIBVA_DRIVER_NAME,nvidia"
        # "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      monitor = [
        ",highres@highrr,0x0,1"
        "eDP-1,preferred,auto-right,1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 2;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      workspace = [
        "9,default:true,monitor:eDP-1"
        "special:magic,gapsout:96"
      ];

      bind =
        [
          "$mod, Return, exec, kitty"
          "$mod, E, exec, nautilus"
          "$mod, B, exec, firefox"
          "$mod SHIFT, B, exec, brave"

          "$mod, P, exec, anyrun"
          "$mod SHIFT, P, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          "$mod SHIFT, C, killactive,"
          "$mod SHIFT, Q, exec, hyprctl dispatch exit"
          "$mod CONTROL, R, exec, hyprctl reload"
          "$mod, M, fullscreen, 1"
          "$mod, F, fullscreen, 0"
          "$mod, Space, togglefloating,"
          "$mod, G, pin,"
          "$mod, O, movewindow, mon:-1 silent"
          "$mod SHIFT, O, swapactiveworkspaces, eDP-1 DP-3"
          "$mod, S, togglespecialworkspace, magic"
          "$mod, J, splitratio, -0.1"
          "$mod, K, splitratio, +0.1"
          "$mod, H, cyclenext, visible prev tiled"
          "$mod, L, cyclenext, visible next tiled"
          "$mod SHIFT, H, swapnext, prev"
          "$mod SHIFT, L, swapnext"
          "$mod, period, focuscurrentorlast"

          "$mod SHIFT, `, exec, hyprlock"
        ]
        ++ (
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      bindl = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "pin, initialTitle:^(Picture-in-Picture)$"
        "keepaspectratio, initialTitle:^(Picture-in-Picture)$"
        "size 25% 25%,initialTitle:^(Picture-in-Picture)$"
        "float, initialTitle:^(Picture-in-Picture)$"
        "bordersize 0, initialTitle:^(Picture-in-Picture)$"

        "pin, class:mpv"
        "keepaspectratio, class:mpv"
        "size 60% 60%, class:mpv"
        "float, class:mpv"
        "bordersize 0, class:mpv"

        "float, class:^([Ff]irefox.*|[Bb]rave.*), initialTitle:^(Save File|Enter name of file to save.*|Open File|File Upload)$"
        "center, class:^([Ff]irefox.*|[Bb]rave.*), initialTitle:^(Save File|Enter name of file to save.*|Open File|File Upload)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
      };
    };
  };
}
