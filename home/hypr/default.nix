{
  pkgs,
  inputs,
  ...
}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

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

    # ".config/uwsm/env-hyprland" = {
    #   text = ''
    #     export LIBVA_DRIVER_NAME=nvidia
    #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
    #   '';
    # };
  };

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
    # set to null so hyprland package from nixos is used
    package = null;

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
        enabled = false;
      };

      exec-once = [
        # "${pkgs.hyprpanel}/bin/hyprpanel"
        # "${pkgs.noctalia-shell}/bin/noctalia-shell"
        # "noctalia-shell"
        "uwsm-terminal -- nm-applet &"
        "uwsm-terminal -- wl-paste --watch cliphist store &"
      ];

      # env = [
      #   "MOZ_ENABLE_WAYLAND,1"
      #   "GDK_BACKEND,wayland"
      #   "QT_QPA_PLATFORM,wayland"
      #   "SDL_VIDEODRIVER,wayland"
      #   "CLUTTER_BACKEND,wayland"
      #   "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      #   "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      #   "NIXOS_OZONE_WL,1"
      #   "ELECTRON_OZONE_PLATFORM_HINT,auto"
      #
      #   "XDG_CURRENT_DESKTOP,Hyprland"
      #   "XDG_SESSION_TYPE,wayland"
      #   "XDG_SESSION_DESKTOP,Hyprland"
      #   "LIBVA_DRIVER_NAME,nvidia"
      #   "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      # ];

      monitor = [
        ",1920x1080@60,0x0,1"
        # ",highres@highrr,0x0,1"
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

      gesture = [
        "3, horizontal, workspace"
      ];

      bind =
        [
          "$mod, Return, exec, uwsm-app -- kitty.desktop"
          "$mod, E, exec, uwsm-app -- nautilus"
          "$mod, B, exec, uwsm-app -- firefox.desktop"
          "$mod SHIFT, B, exec, uwsm-app -- brave --ozone-platform=wayland --disable-features=WaylandWpColorManagerV1"

          # "$mod, P, exec, fuzzel \"--launch-prefix=uwsm-app --\""
          "$mod, P, exec, dms ipc call spotlight toggle"
          "$mod SHIFT, P, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          "$mod SHIFT, C, killactive,"
          "$mod SHIFT, Q, exec, uwsm stop"
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

          "$mod ALT, L, exec, dms ipc call lock lock"
          "$mod, TAB, exec, dms ipc call hypr toggleOverview"
          "$mod, V, exec, dms ipc call clipboard toggle"
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
        # ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        # ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        # ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 3"
        ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 3"
        ", XF86AudioMute, exec, dms ipc call audio mute"
        ", XF86AudioMicMute, exec, dms ipc call audio micmute"
        # ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        # ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5"
        ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      layerrule = [
        "noanim, ^(dms)$"
      ];

      workspace = [
        "9,default:true,monitor:eDP-1"
        "special:magic,gapsout:96"
        "w[tv1]s[false], gapsout:0, gapsin:0"
        "f[1]s[false], gapsout:0, gapsin:0"
      ];

      windowrule = [
        "bordersize 0, floating:0, onworkspace:w[tv1]s[false]"
        "rounding 0, floating:0, onworkspace:w[tv1]s[false]"
        "bordersize 0, floating:0, onworkspace:f[1]s[false]"
        "rounding 0, floating:0, onworkspace:f[1]s[false]"
      ];

      windowrulev2 = [
        "float, class:^(org.quickshell)$"
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
