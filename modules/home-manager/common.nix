{pkgs, ...}: {
  home.packages = with pkgs; [
    brave
    vscodium
    codex
    fastfetch
    btop
    ripgrep
    fd
    fzf
    jq
    tree
    curl
    wget
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
  };
}
