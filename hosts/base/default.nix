{
  inputs,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics.enable = true;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  security.rtkit.enable = true;

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    bolt
    blueman
    mesa

    htop
    btop

    vim
    wget
    kitty
    git
    zsh
    ripgrep
    libadwaita
    gtk4
    ghostty
    starship
    tmux
    lazygit
    quickshell

    home-manager
    nil
    nixd

    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    gnome-keyring
    nautilus

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
    steam
    discord
    google-chrome
    chromium

    (wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    })

    tailscale
  ];

  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.zsh.enable = true;

  services.blueman.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;
  services.hardware.bolt.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.xserver.enable = true;

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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.tailscale = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
