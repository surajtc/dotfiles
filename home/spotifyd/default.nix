{
  config,
  pkgs,
  vars,
  inputs,
  ...
}: {
  services.playerctld.enable = true;

  services.spotifyd = {
    enable = true;
    package = pkgs.spotifyd.override {
      # withKeyring = true;
      withMpris = true;
    };
    settings.global = {
      # username = vars.spotifydUser;
      # password = vars.spotifydPassword;
      use_mpris = true;
      cache_path = ".cache/spotifyd";
      max_cache_size = 1000000000;
      # initial_volume = 70;
      volume_normalization = true;
      autoplay = false;
      disable_discovery = true;
      device_name = "spotifyd-nix";
      device_type = "computer";
      backend = "pulseaudio";
      use_keyring = true;
      bitrate = 160;
      audio_format = "F32";
    };
  };
}
