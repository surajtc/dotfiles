{inputs, lib, pkgs, ...}: let
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

  # Pi manages third-party packages in ~/.pi/agent/settings.json and its
  # package cache. Keep pi-openai-toolkit on the latest npm release whenever
  # a Home Manager generation is activated.
  home.activation.piPackages = lib.hm.dag.entryAfter ["writeBoundary"] ''
    export PATH="${pkgs.nodejs}/bin:$PATH"
    ${lib.concatMapStringsSep "\n" (package: ''
      if ${pi}/bin/pi list 2>/dev/null | ${pkgs.gnugrep}/bin/grep -Fq "${package.name}"; then
        ${pi}/bin/pi update "${package.source}" || echo "warning: could not update ${package.name}"
      else
        ${pi}/bin/pi install "${package.source}" || echo "warning: could not install ${package.name}"
      fi
    '') packages}
  '';
}
