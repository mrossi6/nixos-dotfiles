{ lib, pkgs, ... }:

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
        directory = "/home/mark/walls";
        viewMode = "single";
        fillMode = "crop";
        skipStartupTransition = true;
      };
    };
  };
}
