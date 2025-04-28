{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.sessionVariables = {
    CYPRESS_INSTALL_BINARY = 0;
    CYPRESS_RUN_BINARY = "${pkgs.cypress}/bin/Cypress";
  };

  home.packages = with pkgs; [
    nodejs
    pnpm
    yarn
    cypress
    bun
    turbo-unwrapped

    python3
    uv
  ];
}
