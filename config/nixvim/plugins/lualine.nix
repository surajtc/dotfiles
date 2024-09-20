{
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        options = {
          disabled_filetypes = {
            __unkeyed-1 = "neo-tree";
          };

          component_separators = "";
          section_separators = "";
          globalstatus = true;
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
        winbar = {
          lualine_c = [
            {
              __unkeyed-1 = "navic";
            }
          ];
          lualine_x = [
            {
              __unkeyed-1 = "filename";
              newfile_status = true;
              path = 3;
              shorting_target = 150;
            }
          ];
        };
      };
    };
  };
}
