{
  inputs,
  pkgs,
  ...
}: let
  pi = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
  packages = [
    {
      source = "npm:pi-openai-toolkit";
      name = "pi-openai-toolkit";
    }
    {
      source = "npm:pi-web-access";
      name = "pi-web-access";
    }
    {
      source = "npm:pi-codex-goal";
      name = "pi-codex-goal";
    }
    {
      source = "npm:pi-subagents";
      name = "pi-subagents";
    }
  ];
in {
  home.file.".pi/agent/extensions/pi-openai-toolkit/config.json".text = builtins.toJSON {
    schemaVersion = 2;
    defaults = {
      context.mode = "remote-windows";
      webSearch.route = "hosted";
    };
  };

  # Pi owns ~/.pi/agent/settings.json and its package cache. Keep package
  # installation and updates explicit so Home Manager activation stays fast
  # and does not perform network work during boot or rebuilds.
  home.packages = [
    (pkgs.writeShellScriptBin "pi-sync" ''
      set -euo pipefail
      export PATH="${pkgs.nodejs}/bin:$PATH"

      ${builtins.concatStringsSep "\n" (map (package: ''
          if ${pi}/bin/pi list 2>/dev/null | ${pkgs.gnugrep}/bin/grep -Fq "${package.name}"; then
            ${pi}/bin/pi update "${package.source}"
          else
            ${pi}/bin/pi install "${package.source}"
          fi
        '')
        packages)}

      echo "Pi extensions synchronized."
    '')
  ];
}
