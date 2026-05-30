{ mkShell, pkgs, ... }:
mkShell {
  name = "go";
  packages = with pkgs; [
    delve
    go
    golangci-lint
    gopls
    gotools
  ];
}
