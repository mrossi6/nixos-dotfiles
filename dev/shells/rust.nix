{ mkShell, pkgs, ... }:
mkShell {
  name = "rust";
  packages = with pkgs; [
    cargo
    clippy
    openssl
    pkg-config
    rust-analyzer
    rustc
    rustfmt
  ];
}
