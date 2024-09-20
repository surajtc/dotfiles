{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkForce;
  inherit (config.lib) stylix;

  super = "SUPER";
  super_shift = "SUPER_SHIFT";
  border_color = mkForce "rgb(${stylix.colors.base07})";
in {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        layout = "dwindle";
        allow_tearing = false;
        resize_on_border = false;
        "col.active_border" = border_color;
      };

      decoration = {
        rounding = 4;
        active_opacity = 1;
        inactive_opacity = 1;

        drop_shadow = false;

        blur = {
          enabled = true;
          size = 4;
          passes = 2;
          vibrancy = 0.2;
        };
      };

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "MOZ_ENABLE_WAYLAND,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "${pkgs.hyprpanel}/bin/hyprpanel"
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

      bind = [
        "${super},B,exec,${pkgs.firefox}/bin/firefox"
        "${super_shift},B,exec,${pkgs.brave}/bin/brave"
        "${super},Return,exec,${pkgs.kitty}/bin/kitty"
        "${super_shift},C,killactive,"
        "${super_shift},Q,exit,"
        "${super},E,exec,${pkgs.xfce.thunar}/bin/thunar"
        "${super},Space,togglefloating,"
        "${super},P,exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
        "${super},M,fullscreen,1"
        "${super},F,fullscreen,0"
        # "${super},P,pseudo,"
        # "${super},J,togglesplit,"
        "${super},1,workspace,1"
        "${super},2,workspace,2"
        "${super},3,workspace,3"
        "${super},4,workspace,4"
        "${super},5,workspace,5"
        "${super},6,workspace,6"
        "${super},7,workspace,7"
        "${super},8,workspace,8"
        "${super},9,workspace,9"
        "${super},0,workspace,10"
        "${super},O,movewindow,mon:-1 silent"
        "${super_shift},O,swapactiveworkspaces, eDP-1 DP-3"
        "${super},V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "${super_shift},P,exec,grim -g \"$(slurp -d)\" - | wl-copy"
      ];

      workspace = [
        "10,default:true,monitor:eDP-1"
        "special:magic,gapsout:96"
      ];

      windowrulev2 = [
        "pin,initialTitle:^(Picture-in-Picture)$"
        "keepaspectratio,initialTitle:^(Picture-in-Picture)$"
        "float,initialTitle:^(Picture-in-Picture)$"
        "move 70% 8%,initialTitle:^(Picture-in-Picture)$"
        "size 25% 25%,initialTitle:^(Picture-in-Picture)$"

        "float,class:^([Ff]irefox.*|[Bb]rave.*),initialTitle:^(Save File|Enter name of file to save.*|Open File|File Upload)$"
        "center,class:^([Ff]irefox.*|[Bb]rave.*),initialTitle:^(Save File|Enter name of file to save.*|Open File|File Upload)$"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
      };
    };

    extraConfig = ''

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      $terminal = kitty
      $fileManager = thunar
      $menu = rofi -show drun

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/



      #####################
      ### LOOK AND FEEL ###
      #####################

      # https://wiki.hyprland.org/Configuring/Variables/#decoration


      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations {
          enabled = true

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle {
          pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # You probably want this
      }

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master {
          new_status = master
      }


      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input


      # https://wiki.hyprland.org/Configuring/Variables/#gestures


      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }


      ###################
      ### KEYBINDINGS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/
      $mainMod = SUPER # Sets "Windows" key as main modifier

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d



      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Laptop multimedia keys for volume and LCD brightness
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule v1
      # windowrule = float, ^(kitty)$

      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

      windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
    '';
  };
}
