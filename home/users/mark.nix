{ inputs, pkgs, ... }:
{
  imports = [
    ../desktops/n3
    ../programs/discord.nix
    ../programs/ghostty.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/shell.nix
    ../programs/yazi.nix
    ../programs/zed.nix
    ../programs/zen-browser.nix
    inputs.zen-browser.homeModules.default
    inputs.noctalia.homeModules.default
  ];
}
