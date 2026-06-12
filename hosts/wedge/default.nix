{
  inputs,
  pkgs,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ../base
    ./hardware-configuration.nix
  ];

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = [
    pkgs.openrgb
  ];

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  hardware.bluetooth = {
    settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
  };

  hardware.graphics.enable32Bit = true;

  networking = {
    hostName = "wedge";
    interfaces.ens3 = {
      wakeOnLan.enable = true;
    };
    firewall.allowedUDPPorts = [ 9 ];
  };

  users.users.mark = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  users.users.sofia = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  system.stateVersion = "25.11";
}
