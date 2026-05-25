{
  config,
  pkgs,
  zen-browser,
  ...
}:

let
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  zen-extensions = [
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
  ];

in
{
  imports = [ zen-browser.homeModules.default ];

  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "25.11";
  # home.sessionVariables = {
  #   __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa.drivers}/share/glvnd/egl_vendor.d/50_mesa.json";
  # };
  #
  programs.starship.enable = true;

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "catppuccin"
      "everforest"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha - No Italics";
        light = "Catppuccin Latte - No Italics";
      };
      vim_mode = true;
      ui_font_size = 18;
      buffer_font_family = "CommitMono";
      buffer_font_size = 16;
    };
  };

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    policies = {
      ExtensionSettings = builtins.listToAttrs zen-extensions;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#twist";
    };
    profileExtra = ''
      eval "$(starship init zsh)"

      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec niri --session
      fi
    '';
  };

  home.file.".config/niri".source = ./config/niri;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/starship".source = ./config/starship;

  home.packages = with pkgs; [
    commit-mono
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.systemd.enable = false;

  gtk = {
    enable = true;
  };
}
