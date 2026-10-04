{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    initLua = ''
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/mappings.lua}
      ${builtins.readFile ./lua/debug.lua}
      ${builtins.readFile ./lua/plugins/snacks.lua}
    '';
  };
}
