{
  pkgs,
  config,
  inputs,
  ...
}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;

    settings = {
      # layout = {
      bar.layouts = {
        "*" = {
          left = ["dashboard" "workspaces" "windowtitle"];
          middle = ["clock"];
          right = ["netstat" "ram" "cpu" "volume" "bluetooth" "battery" "systray" "hyprsunset" "notifications"];
        };
      };
      # };

      bar.workspaces.show_icons = false;
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.monitorSpecific = false;
      bar.workspaces.show_numbered = true;
      bar.workspaces.workspaces = 0;
      bar.workspaces.showAllActive = true;
      bar.workspaces.numbered_active_indicator = "highlight";
      bar.customModules.ram.labelType = "used";
      bar.customModules.netstat.dynamicIcon = true;
      bar.customModules.netstat.leftClick = "menu:network";
      bar.customModules.hyprsunset.label = false;

      bar.customModules.hyprsunset.temperature = "5200k";
      bar.customModules.hyprsunset.rightClick = "hyprctl hyprsunset identity";
      bar.customModules.hyprsunset.middleClick = "hyprctl hyprsunset gamma 75";

      theme.font.name = "Inter";
      theme.font.size = "0.96rem";
      theme.font.weight = 500;
      theme.bar.menus.monochrome = true;
      theme.bar.buttons.monochrome = true;
      theme.bar.outer_spacing = "0.8em";
      theme.bar.buttons.y_margins = "0.3em";
      theme.bar.buttons.padding_y = "0.1rem";
      theme.bar.buttons.workspaces.numbered_active_highlight_border = "0.1em";
      theme.bar.buttons.workspaces.numbered_active_highlight_padding = "0.8em";
      theme.bar.buttons.workspaces.numbered_inactive_padding = "0.4em";
      theme.bar.buttons.workspaces.fontSize = "1.12em";

      # theme.bar.menus.background = "${colors.base00}";
      # theme.bar.menus.cards = "${colors.base02}";
      # theme.bar.menus.text = "${colors.base06}";
      # theme.bar.menus.dimtext = "${colors.base04}";
      # theme.bar.menus.feinttext = "${colors.base03}";
      # theme.bar.menus.label = "${colors.base0D}";
      # theme.bar.menus.border.color = "${colors.base00}";
      # theme.bar.menus.popover.text = "${colors.base0D}";
      # theme.bar.menus.popover.background = "${colors.base02}";
      # theme.bar.menus.listitems.active = "${colors.base0D}";
      # theme.bar.menus.listitems.passive = "${colors.base02}";
      # theme.bar.menus.icons.active = "${colors.base0D}";
      # theme.bar.menus.icons.passive = "${colors.base03}";
      #
      # theme.bar.buttons.style = "default";
      # theme.bar.background = "${colors.base00}";
      # theme.bar.border.color = "${colors.base00}";
      # theme.bar.buttons.background = "${colors.base01}";
      # theme.bar.buttons.borderColor = "${colors.base01}";
      # theme.bar.buttons.text = "${colors.base06}";
      # theme.bar.buttons.icon = "${colors.base06}";
      # theme.bar.buttons.icon_background = "${colors.base01}";
      #
      # theme.bar.buttons.workspaces.hover = "${colors.base04}";
      # theme.bar.buttons.workspaces.available = "${colors.base02}";
      # theme.bar.buttons.workspaces.occupied = "${colors.base0D}";
      # theme.bar.buttons.workspaces.active = "${colors.base0D}";
      # theme.bar.buttons.workspaces.numbered_active_highlighted_text_color = "${colors.base02}";
      # theme.bar.buttons.workspaces.numbered_active_underline_color = "${colors.base0D}";
      # theme.bar.buttons.workspaces.border = "${colors.base00}";
      #
      # theme.notification.background = "${colors.base01}";
      # theme.notification.actions.background = "${colors.base02}";
      # theme.notification.actions.text = "${colors.base04}";
      # theme.notification.label = "${colors.base07}";
      # theme.notification.border = "${colors.base02}";
      # theme.notification.time = "${colors.base04}";
      # theme.notification.text = "${colors.base05}";
      # theme.notification.labelicon = "${colors.base04}";
      # theme.notification.close_button.background = "${colors.base0D}";
      # theme.notification.close_button.label = "${colors.base00}";
    };
  };
}
