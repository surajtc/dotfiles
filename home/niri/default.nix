{
  config,
  pkgs,
  vars,
  inputs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.niri = {
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        {
          sh = "wl-paste --watch cliphist store";
        }
      ];
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;

      binds = let
        mod = "Super";
      in {
        # run "niri msg action" to see all available actions
        # Apps
        "${mod}+Return".action.spawn = ["uwsm-app" "--" "kitty.desktop"];
        "${mod}+E".action.spawn = ["uwsm-app" "--" "nautilus"];
        "${mod}+B".action.spawn = ["uwsm-app" "--" "firefox.desktop"];
        "${mod}+Shift+B".action.spawn = ["uwsm-app" "--" "brave"];

        # Launcher
        "${mod}+P".action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
        # TODO: Use satty to optionally annotate
        "${mod}+Shift+P".action."screenshot" = [];

        "${mod}+V".action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
        "${mod}+Alt+L".action.spawn = ["dms" "ipc" "call" "lock" "lock"];

        # Window Management
        "${mod}+M".action."maximize-window-to-edges" = [];
        "${mod}+Shift+M".action."maximize-column" = [];
        "${mod}+F".action."fullscreen-window" = [];
        "${mod}+Space".action."toggle-window-floating" = [];
        "${mod}+Shift+C".action."close-window" = [];
        "${mod}+Comma".action."consume-window-into-column" = [];
        "${mod}+Period".action."expel-window-from-column" = [];
        "${mod}+R".action."switch-preset-column-width" = [];

        "${mod}+Shift+Q".action.spawn = ["uwsm" "stop"];
        "${mod}+Control+R".action.spawn = ["niri" "msg" "reload-config"];

        # Media/Audio keys
        "XF86AudioRaiseVolume".action.spawn = ["dms" "ipc" "call" "audio" "increment" "3"];
        "XF86AudioLowerVolume".action.spawn = ["dms" "ipc" "call" "audio" "decrement" "3"];
        "XF86AudioMute".action.spawn = ["dms" "ipc" "call" "audio" "mute"];
        "XF86AudioMicMute".action.spawn = ["dms" "ipc" "call" "audio" "micmute"];

        # Brightness keys
        "XF86MonBrightnessUp".action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5"];
        "XF86MonBrightnessDown".action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5"];

        # Media player keys
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
        "XF86AudioNext".action.spawn = ["playerctl" "next"];

        # Workspace
        # TODO: Use generators
        "${mod}+1".action."focus-workspace" = 1;
        "${mod}+2".action."focus-workspace" = 2;
        "${mod}+3".action."focus-workspace" = 3;
        "${mod}+4".action."focus-workspace" = 4;
        "${mod}+5".action."focus-workspace" = 5;
        "${mod}+6".action."focus-workspace" = 6;
        "${mod}+7".action."focus-workspace" = 7;
        "${mod}+8".action."focus-workspace" = 8;
        "${mod}+9".action."focus-workspace" = 9;

        "${mod}+Shift+1".action."move-column-to-workspace" = 1;
        "${mod}+Shift+2".action."move-column-to-workspace" = 2;
        "${mod}+Shift+3".action."move-column-to-workspace" = 3;
        "${mod}+Shift+4".action."move-column-to-workspace" = 4;
        "${mod}+Shift+5".action."move-column-to-workspace" = 5;
        "${mod}+Shift+6".action."move-column-to-workspace" = 6;
        "${mod}+Shift+7".action."move-column-to-workspace" = 7;
        "${mod}+Shift+8".action."move-column-to-workspace" = 8;
        "${mod}+Shift+9".action."move-column-to-workspace" = 9;

        # Focus:
        # TODO: Look at window-workspace wrapping, and coloumn-screen wrapping
        "${mod}+Left".action."focus-column-left" = [];
        "${mod}+Right".action."focus-column-right" = [];
        "${mod}+H".action."focus-column-left" = [];
        "${mod}+L".action."focus-column-right" = [];

        "${mod}+Up".action."focus-window-up" = [];
        "${mod}+Down".action."focus-window-down" = [];
        "${mod}+J".action."focus-window-down" = [];
        "${mod}+K".action."focus-window-up" = [];

        # Move:
        "${mod}+Shift+Left".action."move-column-left" = [];
        "${mod}+Shift+Right".action."move-column-right" = [];
        "${mod}+Shift+H".action."move-column-left" = [];
        "${mod}+Shift+L".action."move-column-right" = [];

        "${mod}+Shift+Up".action."move-window-up" = [];
        "${mod}+Shift+Down".action."move-window-down" = [];
        "${mod}+Shift+J".action."move-window-down" = [];
        "${mod}+Shift+K".action."move-window-up" = [];

        # Move window: Next/Previous monitor
        "${mod}+O".action."move-window-to-monitor-previous" = [];

        # Move workspace: Next/Previous monitor
        "${mod}+Shift+O".action."move-workspace-to-monitor-previous" = [];

        # Focus monitor
        "${mod}+Control+Left".action."focus-monitor-left" = [];
        "${mod}+Control+Right".action."focus-monitor-right" = [];
      };

      input = {
        keyboard = {
          numlock = true;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true;
        };
      };

      # Screenshot Path
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      # General
      prefer-no-csd = true;

      layout = {
        gaps = 5;
        # struts = {
        #   top = 0;
        #   right = 10;
        #   bottom = 0;
        #   left = 10;
        # };
        background-color = colors.base00;
        border = {
          enable = true;
          width = 2;
          active.color = colors.base0D;
          inactive.color = colors.base02;
        };
        focus-ring = {
          enable = false;
          width = 1;
          active.color = colors.base0D;
          inactive.color = colors.base02;
        };
        shadow.enable = false;

        preset-column-widths = [
          {proportion = 1. / 3.;}
          {proportion = 1. / 2.;}
          {proportion = 2. / 3.;}
        ];
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 2.;
            top-right = 2.;
            bottom-left = 2.;
            bottom-right = 2.;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
            {
              app-id = "org.quickshell$";
              title = "^Settings$";
            }
            {
              app-id = "org.gnome.Loupe$";
            }
          ];

          open-floating = true;
          border.enable = false;
        }
        {
          matches = [
            {
              app-id = "firefox$";
            }
            {
              app-id = "brave-browser$";
            }
          ];
          # TODO: Update -> open-maximized-to-edges = true;
          open-maximized = true;
          default-column-width.proportion = 0.85;
        }
      ];
    };

    # config = with inputs.niri.lib.kdl; [];
    # config = ''
    #   recent-windows {
    #     highlight {
    #       active-color "#ffffff"
    #       urgent-color "#ff9999ff"
    #       padding 30
    #       corner-radius 2
    #     }
    #   }
    # '';
  };
}
