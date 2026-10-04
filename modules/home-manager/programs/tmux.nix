{config, pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-Space";
    baseIndex = 1;
    mouse = true;
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      vim-tmux-navigator
    ];

    extraConfig = let
      colors = config.lib.stylix.colors.withHashtag;
    in ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

        set -s extended-keys on
        set -g extended-keys-format csi-u
        set -as terminal-features 'xterm*:extkeys'
        set -g set-clipboard on

        set -g status-style bg="${colors.base01}"
      set -g status-left "#{?client_prefix,#[bg=${colors.base0A}],#[bg=${colors.base0D}]}#[fg=${colors.base00}]  #S "

      setw -g window-status-current-style "fg=${colors.base04} bg=${colors.base02}"
      set-window-option -g window-status-current-format " #I:#W "
      setw -g window-status-style "fg=${colors.base04}"
      set-window-option -g window-status-format " #I:#W "

      set -g status-right-style "fg=${colors.base03}"
      set -g status-right "#{?window_bigger,[#{window_offset_x}#,#{window_offset_y}] ,} #{=21:pane_title} "
    '';
  };
}
