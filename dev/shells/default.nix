{
  lib,
  pkgs,
  system,
}:
let
  shared = import ./shared.nix {
    inherit lib pkgs system;
  };
  shellArgs = shared // {
    inherit pkgs;
  };
in
rec {
  default = nix;
  go = import ./go.nix shellArgs;
  nix = import ./nix.nix shellArgs;
  node = import ./node.nix shellArgs;
  python = import ./python.nix shellArgs;
  rust = import ./rust.nix shellArgs;
}
