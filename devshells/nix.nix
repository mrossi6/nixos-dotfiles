{ mkShell, pkgs, ... }:
mkShell {
  name = "nix";
  packages = with pkgs; [
    alejandra
    deadnix
    home-manager
    nil
    nixd
    nixfmt
    statix
  ];
}
