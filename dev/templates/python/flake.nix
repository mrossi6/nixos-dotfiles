{

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    dots = {
      url = "git+https://github.com/mrossi6/nixos-dotfiles.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      dots,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          devshells = dots.devShells.${system};
        in
        {
          default = pkgs.mkShell {
            inputsFrom = [
              devshells.python
            ];

            packages = [

            ];

            shellHook = ''
              # Project-specific env setup
            '';
          };
        }
      );
    };

}
