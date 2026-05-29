{ inputs, ... }:
{
  imports = [
    ../default.nix
    ../modules/common.nix
    inputs.zen-browser.homeModules.default
    inputs.noctalia.homeModules.default
    ../modules/linux.nix
  ];

  # Host-specific Home Manager settings for the NixOS laptop go here.
}
