{
  pkgs,
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

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    bolt
    blueman
    mesa

    vim
    wget
    kitty
    git
    zsh
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

    xwayland-satellite
    steam
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
  services.flatpak.enable = true;
  services.hardware.bolt.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

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

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
