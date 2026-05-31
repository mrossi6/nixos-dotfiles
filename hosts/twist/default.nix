# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  ...
}:

{

  imports = [
    ../base
    ./hardware-configuration.nix
  ];

  networking.hostName = "twist";

  users.users.mark = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };
  system.stateVersion = "25.11";
}
