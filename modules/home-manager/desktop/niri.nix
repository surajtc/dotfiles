{pkgs, ...}: {
  programs.niri.settings = {
    hotkey-overlay.skip-at-startup = true;
    prefer-no-csd = true;
    clipboard.disable-primary = true;
    environment.NIXOS_OZONE_WL = "1";

    debug.honor-xdg-activation-with-invalid-serial = true;

    spawn-at-startup = [{argv = ["noctalia"];}];

    binds = let
      noctalia = command: ["noctalia" "msg"] ++ command;
    in {
      # Applications and Noctalia surfaces
      "Mod+Return".action.spawn = ["kitty"];
      "Mod+B".action.spawn = ["brave"];
      "Mod+E".action.spawn = ["${pkgs.nautilus}/bin/nautilus"];
      "Mod+P".action.spawn = noctalia ["panel-toggle" "launcher"];
      "Mod+V".action.spawn = noctalia ["panel-toggle" "clipboard"];
      "Mod+S".action.spawn = noctalia ["panel-toggle" "control-center"];
      "Mod+Shift+Comma".action.spawn = noctalia ["settings-toggle"];
      "Mod+Alt+L".action.spawn = noctalia ["session" "lock"];
      "Mod+Shift+P".action.spawn = noctalia ["screenshot-region"];

      # Window management
      "Mod+M".action.maximize-window-to-edges = [];
      "Mod+Shift+M".action.maximize-column = [];
      "Mod+F".action.fullscreen-window = [];
      "Mod+Space".action.toggle-window-floating = [];
      "Mod+Shift+C".action.close-window = [];
      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];
      "Mod+R".action.switch-preset-column-width = [];
      "Mod+Shift+Q".action.spawn = noctalia ["session" "logout"];
      "Mod+Control+R".action.spawn = ["niri" "msg" "action" "reload-config"];

      # Audio, microphone, brightness, and media
      "XF86AudioRaiseVolume".action.spawn = noctalia ["volume-up" "3"];
      "XF86AudioLowerVolume".action.spawn = noctalia ["volume-down" "3"];
      "XF86AudioMute".action.spawn = noctalia ["volume-mute"];
      "XF86AudioMicMute".action.spawn = noctalia ["mic-mute"];
      "XF86MonBrightnessUp".action.spawn = noctalia ["brightness-up" "5"];
      "XF86MonBrightnessDown".action.spawn = noctalia ["brightness-down" "5"];
      "XF86AudioPlay".action.spawn = noctalia ["media" "toggle"];
      "XF86AudioPrev".action.spawn = noctalia ["media" "previous"];
      "XF86AudioNext".action.spawn = noctalia ["media" "next"];

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;
      "Mod+Shift+6".action.move-column-to-workspace = 6;
      "Mod+Shift+7".action.move-column-to-workspace = 7;
      "Mod+Shift+8".action.move-column-to-workspace = 8;
      "Mod+Shift+9".action.move-column-to-workspace = 9;

      # Focus and move columns/windows
      "Mod+Left".action.focus-column-left = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+H".action.focus-column-left = [];
      "Mod+L".action.focus-column-right = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Down".action.focus-window-down = [];
      "Mod+J".action.focus-window-down = [];
      "Mod+K".action.focus-window-up = [];
      "Mod+Shift+Left".action.move-column-left = [];
      "Mod+Shift+Right".action.move-column-right = [];
      "Mod+Shift+H".action.move-column-left = [];
      "Mod+Shift+L".action.move-column-right = [];
      "Mod+Shift+Up".action.move-window-up = [];
      "Mod+Shift+Down".action.move-window-down = [];
      "Mod+Shift+J".action.move-window-down = [];
      "Mod+Shift+K".action.move-window-up = [];

      # Monitor movement
      "Mod+O".action.move-window-to-monitor-previous = [];
      "Mod+Shift+O".action.move-workspace-to-monitor-previous = [];
      "Mod+Control+Left".action.focus-monitor-left = [];
      "Mod+Control+Right".action.focus-monitor-right = [];
    };

    input = {
      keyboard.numlock = true;
      mouse = {
        accel-profile = "flat";
        accel-speed = 0.0;
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true;
      };
    };

    layout = {
      gaps = 5;
      border = {
        enable = true;
        width = 2;
      };
      focus-ring.enable = false;
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
          {app-id = "org.gnome.Loupe$";}
          {title = "Picture in picture";}
        ];
        open-floating = true;
        border.enable = false;
      }
      {
        matches = [{app-id = "brave-browser$";}];
        open-maximized = true;
        default-column-width.proportion = 0.85;
      }
      {
        matches = [{app-id = "dev.noctalia.Noctalia$";}];
        open-floating = true;
        default-column-width.fixed = 1080;
        default-window-height.fixed = 920;
      }
    ];
  };

}
