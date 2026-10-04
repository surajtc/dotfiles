{...}: {
  programs.nsticky = {
    enable = true;

    settings = {
      sticky.picture-in-picture.title = "Picture in picture";
      sticky.brave-web-apps.app-id = "^brave-.*-Default$";
    };
  };
}
