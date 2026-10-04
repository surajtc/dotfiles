{pkgs, ...}: {
  programs.neovim.extraPackages = with pkgs; [
    gcc
    ripgrep
    fzf
    stylua
    lua-language-server
    nodejs
    prettier
    prettierd
    tailwindcss-language-server
    biome
    astro-language-server
    alejandra
    pyright
    (python3.withPackages (ps:
      with ps; [
        isort
        black
      ]))
  ];
}
