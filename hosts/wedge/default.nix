{
  pkgs,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ../base
    ./hardware-configuration.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.bluetooth = {
    settings.General = {
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
  };

  hardware.graphics.enable32Bit = true;

  networking.hostName = "wedge";

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

  programs.firefox.enable = true;
  programs.niri.enable = true;

  security.rtkit.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  system.stateVersion = "25.11";

}
