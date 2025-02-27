{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.anyrun = {
    enable = true;

    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.1;};
      width = {fraction = 0.3;};
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;

      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.dictionary
        inputs.anyrun.packages.${pkgs.system}.websearch
      ];
    };

    extraCss = ''
      window {
        background-color: rgba(0, 0, 0, 0.75);
      }
    '';
  };
}
