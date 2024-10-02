{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    stylix,
    # nixvim,
    ...
  } @ inputs: let
    default = "nixos";
    variables = import ./hosts/${default}/variables.nix;

    hostName = variables.hostName;
    userName = variables.userName;
  in {
    # nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
    #   specialArgs = {
    #     inherit variables;
    #     inherit inputs;
    #   };
    #   system = "x86_64-linux";
    #   modules = [
    #     ./hosts/${hostName}/configuration.nix

    #     home-manager.nixosModules.home-manager
    #     {
    #       home-manager.extraSpecialArgs = {
    #         inherit variables;
    #         inherit inputs;
    #       };
    #       home-manager.useGlobalPkgs = true;
    #       home-manager.useUserPackages = true;

    #       home-manager.sharedModules = [
    #         nixvim.homeManagerModules.nixvim
    #         stylix.homeManagerModules.stylix
    #       ];

    #       home-manager.backupFileExtension = "backup";

    #       home-manager.users.${userName} = import ./hosts/${hostName}/home.nix;
    #     }

    #     {
    #       nixpkgs.overlays = [inputs.hyprpanel.overlay];
    #       _module.args = {inherit inputs;};
    #     }
    #   ];
    # };

    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit variables;
        inherit inputs;
      };

      system = "x86_64-linux";

      modules = [
        ./hosts/${hostName}/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.extraSpecialArgs = {
            inherit variables;
            inherit inputs;
          };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.sharedModules = [
            stylix.homeManagerModules.stylix
          ];

          home-manager.backupFileExtension = "backup";

          home-manager.users.${userName} = import ./hosts/${hostName}/home.nix;
        }
      ];
    };
  };
}
