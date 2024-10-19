{pkgs, ...}: {
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

    extraConfig = ''
      set-option -g status-position top

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind -n C-l send-keys C-l

    '';
  };
}
# bind-key -T copy-mode-vi v send-keys -X begin-selection
# bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
# bind-key -T comp-mode-vi y send-keys -X copy-selection-and-cancel

