{pkgs, ...}: {
  home.packages = with pkgs; [
    openconnect
    wlrctl
  ];

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

    shellAliases = {
      c = "clear";
      ll = "ls -la";
      ee = "tree -L 3";

      ga = "git add .";
      gc = "git commit -m";
      gp = "git push -u origin";
      gs = "git status";

      nixedit = "cd /etc/dotfiles && nvim";
      nixrebuild = "sudo nixos-rebuild switch --show-trace --flake .";

      cattlabvpn = "sudo OPENSSL_CONF=/etc/openconnect/openssl.conf openconnect --user=stelugar --csd-wrapper=/etc/openconnect/csd-post.sh vpn.cattlab.umd.edu";
    };

    initContent = "fastfetch";
  };

  programs.starship.enable = true;
}
