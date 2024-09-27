{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    stylix.url = "github:danth/stylix";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    nixvim,
    stylix,
    ...
  } @ inputs: let
    default = "machine";
    variables = import ./hosts/${default}/variables.nix;

    hostName = variables.hostName;
    userName = variables.userName;
  in {
    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit variables;
        inherit inputs;
      };
      system = "x86_64-linux";
      modules = [
        ./hosts/${hostName}/configuration.nix

        nixos-hardware.nixosModules.dell-xps-15-9520-nvidia

        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit variables;
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.sharedModules = [
            nixvim.homeManagerModules.nixvim
            stylix.homeManagerModules.stylix
          ];

          home-manager.backupFileExtension = "backup";

          home-manager.users.${userName} = import ./hosts/${hostName}/home.nix;
        }

        {
          nixpkgs.overlays = [inputs.hyprpanel.overlay];
          _module.args = {inherit inputs;};
        }
      ];
    };
  };
}
