{
  description = "marks nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # Cherry-pick specific package versions (e.g. azure-cli) without tracking
    # bleeding-edge nixos-unstable for the whole system. Pin explicitly and
    # bump/revert deliberately.
    # Currently pinned for azure-cli 2.84.0 (2.87.0+ has a JsonCTemplatePolicy
    # key-order regression).
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/59adee2382bad4c477d2e0c9580ad3eb41d51e4d";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    paneru = {
      url = "github:karinushka/paneru";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pi = {
      url = "github:lukasl-dev/pi.nix";
    };
    pixie-sddm = {
      url = "github:xCaptaiN09/pixie-sddm";
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
      mkHmUser =
        {
          username,
          stateVersion,
          imports ? [ ],
          homeDirectory ? "/home/${username}",
        }:
        {
          inherit imports;
          home = {
            inherit username homeDirectory stateVersion;
          };
        };
      mkHome =
        {
          system,
          username,
          homeDirectory,
          stateVersion,
          hostModule,
          extraSpecialArgs ? { },
          extraModules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = {
            inherit inputs;
            nixosFlakeTarget = null;
          }
          // extraSpecialArgs;
          modules = [
            hostModule
            {
              home = {
                inherit username homeDirectory stateVersion;
              };
            }
          ]
          ++ extraModules;
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
              users.mark = mkHmUser {
                username = "mark";
                stateVersion = "25.11";
                imports = [ ./home/users/mark.nix ];
              };
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
                nixosFlakeTarget = "twist";
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
              users.mark = mkHmUser {
                username = "mark";
                stateVersion = "25.11";
                imports = [ ./home/users/mark.nix ];
              };
              users.sofia = mkHmUser {
                username = "sofia";
                stateVersion = "25.11";
              };
              backupFileExtension = "backup";
              extraSpecialArgs = {
                inherit inputs;
                nixosFlakeTarget = "wedge";
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
          stateVersion = "25.11";
          hostModule = ./home/hosts/work-mac.nix;
          extraSpecialArgs = {
            homeFlakeTarget = "markrossi@work-mac";
          };
        };
      };

      devShells = forAllSystems (
        system:
        import ./dev/shells {
          inherit lib system;
          pkgs = mkPkgs system;
        }
      );

      templates = {
        python = {
          path = ./dev/templates/python;
          description = "Basic Python project template";
        };
        default = {
          path = ./dev/templates;
          description = "Slim project template";
        };
      };
    };

}
