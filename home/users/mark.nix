{ inputs, pkgs, ... }:
{
  imports = [
    ../desktops/n3
    ../programs/ghostty.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/shell.nix
    ../programs/zed.nix
    ../programs/zen-browser.nix
    inputs.zen-browser.homeModules.default
    inputs.noctalia.homeModules.default
  ];
}
