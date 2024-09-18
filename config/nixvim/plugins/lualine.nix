{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        options = {
          component_separators = "";
          section_separators = "";
        };

        sections = {
          lualine_a = [
            {
              __unkeyed-1 = "mode";
              fmt = ''
                function(str)
                    return str:sub(1,1)
                end
              '';
            }
          ];
          lualine_c = [
            {
              __unkeyed-1 = "buffers";
              icons_enabled = false;
            }
          ];
        };
      };
    };
  };
}
