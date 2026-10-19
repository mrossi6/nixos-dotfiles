# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelModules = [ "9p" "9pnet_virtio" ];

  fileSystems."/mnt/macos-raw" = {
    device = "share";
    fsType = "9p";
    options = [
      "trans=virtio"
      "version=9p2000.L"
      "nofail"
      "rw"
      "_netdev"
    ];
  };

  fileSystems."/home/mark/repos" = {
    device = "/mnt/macos-raw";
    fsType = "fuse.bindfs";
    options = [
      "force-user=1000"
      "force-group=1000"
      "nofail"
      "_netdev"
      "x-systemd.requres=/mnt/macos-raw"
      "x-systemd.after=/mnt/macos-raw"
    ];
  };


  networking.hostName = "ghost";

  hardware.graphics.enable = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
  };

  services.spice-vdagentd.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mark = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  # programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    tmux
    lazygit
    ghostty
    ghostty.terminfo
    bindfs
    quickshell
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
    nautilus

    (writeShellScriptBin "xrandr-auto" ''
          ${pkgs.xrandr}/bin/xrandr --output Virtual-1 --auto
        '')

    (inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
      primaryColor = "#B3C8FF";
      accentColor = "#3F5F91";
      autoColor = true;
      backgroundColor = "#1A1C1E";
      textColor = "E2E2E6";
      fontFamily = "Commit Mono";
      fontSize = 13;
    })

    xwayland-satellite
  ];

  environment.variables.LIBGL_ALWAYS_SOFTWARE = "1";

  programs.niri.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "pixie";
    package = lib.mkForce pkgs.kdePackages.sddm;
    extraPackages = [
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qt5compat
    ];
  };

  services.openssh.enable = true;

  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; # Did you read the comment?
}
