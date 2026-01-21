{
  description = "Nixos Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # quickshell = {
    #   url = "github:outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    vars = import ./hosts/machine/vars.nix;
  in {
    nixosConfigurations.machine = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs vars;
      };
      system = "x86_64-linux";
      modules = [
        ./hosts/machine/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs vars;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            inputs.stylix.homeModules.stylix
            inputs.niri.homeModules.stylix
            inputs.niri.homeModules.config
            # inputs.noctalia.homeModules.default
          ];

          home-manager.backupFileExtension = "backup";
          home-manager.users.${vars.userName} = import ./hosts/machine/home.nix;
        }

        {
          nixpkgs.overlays = [
            # (import ./overlays/spotify-spotx.nix)
          ];
        }
      ];
    };
  };
}
