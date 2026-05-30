{
  description = "marks nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
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
      homeModulesFor =
        system:
        [
          ./home
          ./home/modules/common.nix
        ]
        ++ lib.optionals (lib.hasSuffix "linux" system) [
          inputs.zen-browser.homeModules.default
          inputs.noctalia.homeModules.default
          ./home/modules/linux.nix
        ]
        ++ lib.optionals (lib.hasSuffix "darwin" system) [
          ./home/modules/darwin.nix
        ];
      mkHome =
        {
          system,
          username,
          homeDirectory,
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit inputs username homeDirectory;
          };
          modules = homeModulesFor system ++ extraModules;
        };
    in
    {
      nixosConfigurations.twist = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.mark = {
                imports = homeModulesFor "x86_64-linux";
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

      homeConfigurations = {
        "mark@twist" = mkHome {
          system = "x86_64-linux";
          username = "mark";
          homeDirectory = "/home/mark";
        };
        "markrossi@work-mac" = mkHome {
          system = "aarch64-darwin";
          username = "markrossi";
          homeDirectory = "/Users/markrossi";
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
