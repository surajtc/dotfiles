{inputs, ...}: {
  xdg.dataFile."noctalia/plugins/niri-displays".source = "${inputs.noctalia-community-plugins}/niri-displays";

  programs.noctalia = {
    enable = true;
    checkConfig = true;

    settings = {
      bar.default = {
        capsule = true;
        capsule_border_width = 0;
        capsule_radius = 4;
        capsule_thickness = 0.78;
        font_scale = 0.94;
        center = ["clock" "weather" "media"];
        compositor_blur = false;
        concave_edge_corners = false;
        end = [
          "temp"
          "ram"
          "cpu"
          "network_rx"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          # "display-settings"
          "tray"
          "notifications"
        ];
        margin_ends = 0;
        padding = 12;
        radius = 0;
        shadow = false;
        start = ["control-center" "launcher" "taskbar" "active_window"];
        thickness = 30;
      };

      control_center = {
        sidebar = "full";
        sidebar_section = "compact";
      };

      location.auto_locate = true;

      lockscreen = {
        transition = ["fade"];
        transition_duration = 500;
      };

      plugins.enabled = ["raycursive/niri-displays"];

      shell.corner_radius_scale = 0.5;

      # Keep the login screen in sync with Noctalia's active appearance and
      # output layout. Authorization remains governed by Polkit.
      shell.greeter_sync.auto_sync = true;

      wallpaper.enabled = false;

      osd = {
        background_opacity = 1.0;
        position = "bottom_center";
        position_vertical = "center_right";
      };

      shell.panel = {
        clipboard_placement = "floating";
        control_center_placement = "floating";
        floating_offset = 4;
        launcher_placement = "floating";
        open_near_click_control_center = true;
        open_near_click_session = true;
        shadow = false;
        session_placement = "floating";
        wallpaper_placement = "floating";
      };

      shell.session.grid = true;

      shell.popup_shadows = false;

      widget.active_window.title_scroll = "on_hover";
      widget."display-settings" = {
        enable_scroll = false;
        show_resolution = false;
        type = "raycursive/niri-displays:bar";
      };
      widget."control-center".glyph = "layout-grid";
      widget.media = {
        album_art_only = true;
        hide_when_no_media = true;
      };
      widget.cpu.visualization = "none";
      widget.battery.hide_when_plugged = true;
      widget.network_rx = {
        glyph = "arrow-down";
        network_speed_compact = true;
        network_speed_unit = "mb";
        visualization = "none";
      };
      widget.network.show_label = false;
      widget.ram.visualization = "none";
      widget.taskbar = {
        empty_color = "outline";
        font_scale = 1.42;
        font_weight = 700;
        group_by_workspace = true;
        group_single_icon_per_app = true;
        hide_empty_workspaces = true;
        icon_scale = 1.15;
        inactive_opacity = 0.7;
        minimal = true;
        occupied_color = "outline";
        show_active_indicator = false;
        workspace_group_capsule = false;
        workspace_label_placement = "inside";
      };
      widget.temp.visualization = "none";
    };
  };
}
