{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      cursor_shape = "block";
      window_padding_width = 10;
      shell = "${pkgs.zsh}/bin/zsh";
      enable_audio_bell = false;
    };
  };
}
