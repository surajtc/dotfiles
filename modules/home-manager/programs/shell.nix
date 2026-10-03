{pkgs, ...}: {
  # Shared aliases are available in both Bash and Zsh.
  home.shellAliases = {
    c = "clear";
    ll = "ls -la";
    ee = "tree -L 3";

    ga = "git add .";
    gc = "git commit -m";
    gp = "git push -u origin";
    gs = "git status";

    nix-edit = "cd /etc/dotfiles && nvim";
    nix-format = "nix fmt /etc/dotfiles";
    nix-rebuild = "sudo nixos-rebuild switch --show-trace --flake /etc/dotfiles#machine";
    nix-cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d && sleep 2 && sudo /run/current-system/bin/switch-to-configuration boot";
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Keep Bash history useful and resilient in TTY/rescue environments.
      export HISTCONTROL=ignoreboth:erasedups
      export HISTSIZE=10000
      export HISTFILESIZE=20000
      shopt -s histappend cmdhist lithist
    '';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.ignoreDups = true;
    history.ignoreAllDups = true;
    history.ignoreSpace = true;
    historySubstringSearch.enable = true;
    defaultKeymap = "emacs";
    cdpath = ["$HOME/Documents" "$HOME/Documents/CodeBase"];
    initContent = "fastfetch";
  };

  programs.starship.enable = true;
}
