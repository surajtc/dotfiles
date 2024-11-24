{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-Space";
    baseIndex = 1;
    mouse = true;
    terminal = "screen-256color";
    # keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      # yank
      vim-tmux-navigator
    ];
    extraConfig = let
      colors = config.lib.stylix.colors.withHashtag;
    in ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

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
# bind -n C-x-L send-keys C-l
# set-option -g status-position top
# bind-key -T copy-mode-vi v send-keys -X begin-selection
# bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
# bind-key -T comp-mode-vi y send-keys -X copy-selection-and-cancel

