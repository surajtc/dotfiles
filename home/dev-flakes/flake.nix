{
  description = "Python + Node dev flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [self.overlays.default];
    };
  in {
    overlays.default = final: prev: rec {
      nodejs = prev.nodejs;
      yarn = prev.yarn.override {inherit nodejs;};
    };

    devShells.${system}.default = pkgs.mkShellNoCC {
      packages = with pkgs; [
        nodejs
        nodePackages.pnpm
        bun

        python3
        uv

        gcc
        go
        gopls
        gotools
        air
        goose
        oapi-codegen
      ];
    };
  };
}
