{ mkShell, pkgs, ... }:
mkShell {
  name = "node";
  packages = with pkgs; [
    nodejs_22
    pnpm
    prettierd
    typescript
    typescript-language-server
  ];
}
