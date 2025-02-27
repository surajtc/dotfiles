{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      enable_audio_bell = "no";
      shell = "zsh";
    };
  };
}
