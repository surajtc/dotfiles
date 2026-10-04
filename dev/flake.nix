{
  description = "Shared development shell for projects under CodeBase";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nodejs
          pnpm
          bun
          python314
          uv
          gcc
          go
          gopls
          gotools
          air
          goose
          oapi-codegen
          rustc
          cargo
          rustfmt
          clippy
        ];
      };
    });
  };
}
