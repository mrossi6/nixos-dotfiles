{ lib, pkgs, ... }:

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
  programs.noctalia-shell = {
    enable = true;
    settings = {
      appLauncher = {
        position = "center";
        overviewLayer = true;
        viewMode = "grid";
      };
      bar = {
        density = "compact";
        position = "right";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          center = [
            {
              hideUnoccupied = true;
              id = "Workspace";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes = {
        useWallpaperColors = true;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        generationMethod = "fruit-salad";
        syncGsettings = true;
      };
      general = {
        radiusRatio = 0.2;
      };
      location = {
        monthBeforeDay = true;
        name = "Richmond, Virginia";
      };
      lockScreenBlur = 40;
      wallpaper = {
        enabled = true;
        overviewEnabled = true;
        directory = "/home/mark/walls";
        viewMode = "single";
        fillMode = "crop";
        skipStartupTransition = true;
        overviewBlur = 0.4;
        overviewTint = 0.6;
      };
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
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#twist";
    };
    profileExtra = lib.mkAfter ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "''${XDG_VTNR:-0}" -eq 1 ]; then
        exec niri --session
      fi
    '';
  };

  home.file.".config/niri".source = ../../config/niri;

  home.packages = with pkgs; [
    commit-mono
  ];

  fonts.fontconfig.enable = true;

  wayland.windowManager.hyprland.systemd.enable = false;

  gtk.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 32;

    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "BreezeX-RosePine-Linux";
    XCURSOR_SIZE = "32";
  };
}
