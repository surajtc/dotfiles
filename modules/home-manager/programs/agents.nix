{
  inputs,
  pkgs,
  ...
}: let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    agents.codex
    agents.pi
    agents.herdr
  ];
}
