{
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = {
          n_lines = 500;
          search_method = "cover_or_next";
        };

        surround = {};

        pairs = {};

        comment = {
          mappings = {
            comment = "";
            comment_line = "<C-/>";
            comment_visual = "<C-/>";
            textobject = "<C-/>";
          };
        };
      };
    };
  };
}
