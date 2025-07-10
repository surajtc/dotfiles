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

    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.machine = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      system = "x86_64-linux";
      modules = [
        ./hosts/machine/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
            inputs.stylix.homeModules.stylix
            # inputs.hyprpanel.homeManagerModules.hyprpanel
            inputs.spicetify-nix.homeManagerModules.spicetify
          ];

          home-manager.backupFileExtension = "backup";
          home-manager.users.admin = import ./hosts/machine/home.nix;
        }

        {
          nixpkgs.overlays = [
            # inputs.hyprpanel.overlay
            # (import ./overlays/spotify-spotx.nix)
          ];
        }
      ];
    };
  };
}
