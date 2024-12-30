{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For git version of AwesomeWM
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
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
    ...
  } @ inputs: let
    mkSystem = {
      hostName,
      vars,
      extraModules ? [],
    }:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit vars inputs;
        };
        system = "x86_64-linux";
        modules =
          [
            ./hosts/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit vars inputs;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                inputs.stylix.homeManagerModules.stylix
                # inputs.nixvim.homeManagerModules.nixvim
              ];
              home-manager.backupFileExtension = "backup";
              home-manager.users.${vars.userName} = import ./hosts/${hostName}/home.nix;
            }
          ]
          ++ extraModules;
      };

    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      # machine = mkSystem {
      # hostName = (import ./hosts/machine/vars.nix).hostName;
      # vars = import ./hosts/machine/vars.nix;
      # extraModules = [
      #   {
      #     nixpkgs.overlays = [inputs.hyprpanel.overlay];
      #     _module.args = {inherit inputs;};
      #   }
      # ];
      # };
      nixos = mkSystem {
        hostName = (import ./hosts/nixos/vars.nix).hostName;
        vars = import ./hosts/nixos/vars.nix;
        extraModules = [
          {
            nixpkgs.overlays = [inputs.nixpkgs-f2k.overlays.window-managers];
          }
        ];
      };
    };

    devShells.${system} = {
      default = pkgs.buildFHSEnv {
        name = "python-dev";
        packages = with pkgs; [
          (python3.withPackages (ps:
            with ps; [
              pandas
              numpy
              requests
              pip
              uv
            ]))
        ];

        shellHook = ''
          echo "Python development environment activated"
          echo "Python version: $(python --version)"
        '';
      };

      cypress = pkgs.buildFHSEnv {
        name = "cypress-dev";
        targetPkgs = pkgs:
          with pkgs; [
            nodejs
            pnpm
            yarn
          ];

        shellHook = ''
          echo "Node development environment activated"
          echo "Node version: $(node --version)"
        '';
      };
    };
  };
}
