{
  description = "marks nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paneru = {
      url = "github:karinushka/paneru";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs systems;
      mkPkgs = system: import nixpkgs { inherit system; };
      mkHome =
        {
          system,
          username,
          homeDirectory,
          hostModule,
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit inputs username homeDirectory;
          };
          modules = [ hostModule ] ++ extraModules;
        };
    in
    {
      nixosConfigurations.twist = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/twist
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mark = {
                imports = [ ./home/users/mark.nix ];
              };
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
                username = "mark";
                homeDirectory = "/home/mark";
              };
            };
          }
        ];
      };

      nixosConfigurations.wedge = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wedge
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mark = {
                imports = [ ./home/users/mark.nix ];
                home = {
                  username = "mark";
                  homeDirectory = "/home/mark";
                  stateVersion = "25.11";
                };
              };
              users.sofia = {
                imports = [ ./home/users/sofia.nix ];
                home = {
                  username = "sofia";
                  homeDirectory = "/home/sofia";
                  stateVersion = "25.11";
                };
              };
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };

      homeConfigurations = {
        "markrossi@work-mac" = mkHome {
          system = "aarch64-darwin";
          username = "markrossi";
          homeDirectory = "/Users/markrossi";
          hostModule = ./home/hosts/work-mac.nix;
        };
      };

      devShells = forAllSystems (
        system:
        import ./devshells {
          inherit lib system;
          pkgs = mkPkgs system;
        }
      );
    };
}
