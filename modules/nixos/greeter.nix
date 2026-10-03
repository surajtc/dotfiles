{pkgs, ...}: {
  services.displayManager.noctalia-greeter = {
    enable = true;
    passwordlessSyncUsers = ["admin"];
    settings = {
      session.default = "niri";
      appearance = {
        hide_logo = true;
        scheme = "Synced";
        scheme_selector_position = "hidden";
      };
      cursor.size = 24;
      keyboard.layout = "us";
    };
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
}
