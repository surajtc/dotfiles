{
  inputs,
  pkgs,
  ...
}: let
  agents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  home.packages = [
    pkgs.skills
    agents.codex
    agents.pi
    agents.herdr
  ];
}
