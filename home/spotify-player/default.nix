{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.spotify-player = {
    enable = true;
    settings = {
      playback_window_position = "Bottom";
      border_type = "Rounded";
      enable_notify = false;
    };
  };
}
