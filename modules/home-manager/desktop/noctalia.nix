{ ... }:
{
  programs.noctalia = {
    enable = true;
    checkConfig = true;

    settings = {
      bar.default = {
        capsule = true;
        capsule_border_width = 0;
        capsule_radius = 4;
        capsule_thickness = 0.78;
        center = ["clock" "weather" "media"];
        compositor_blur = false;
        concave_edge_corners = false;
        end = [
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "notifications"
          "tray"
        ];
        margin_ends = 0;
        padding = 12;
        radius = 0;
        shadow = false;
        start = ["control-center" "launcher" "workspaces" "active_window"];
        thickness = 30;
      };

      control_center = {
        sidebar = "full";
        sidebar_section = "none";
      };

      location.auto_locate = true;

      osd = {
        background_opacity = 1.0;
        position = "bottom_center";
        position_vertical = "center_right";
      };

      shell.panel = {
        open_near_click_control_center = true;
        open_near_click_session = true;
      };

      shell.session.grid = true;

      widget.active_window.title_scroll = "on_hover";
      widget."control-center".glyph = "layout-grid";
      widget.media.hide_when_no_media = true;
      widget.workspaces = {
        empty_color = "outline";
        labels_only_when_occupied = true;
        occupied_color = "tertiary";
      };
    };
  };
}
