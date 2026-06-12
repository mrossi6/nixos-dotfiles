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
        density = "spacious";
        barType = "simple";
        displayMode = "auto_hide";
        position = "right";
        showOutline = false;
        showCapsule = true;
        widgetSpacing = 6;
        contentPadding = 2;
        fontScale = 1.2;
        backgroundOpacity = 0.2;
        useSeparateOpacity = true;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        hideOnOverview = false;
        autoHideDelay = 500;
        autoShowDelay = true;
        showOnWorkspaceSwitch = true;
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
            {
              id = "Volume";
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = true;
            }
          ];
          right = [
            {
              id = "SystemMonitor";
              compactMode = true;
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskAvailable = false;
              showDiskUsage = false;
              showGpuTemp = true;
              showMemoryUsage = true;
              showMemoryAsPercent = true;
              showNetworkStats = false;
              useMonospaceFont = true;
              usePadding = false;

            }
            {
              id = "Battery";
              alwaysShowPercentage = false;
              warningThreshold = 30;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
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
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = true;
        largeButtonsLayout = "single-row";
        powerOptions = [
          {
            action = "lock";
            keybind = "1";
          }
          {
            action = "suspend";
            keybind = "2";
          }
          {
            action = "reboot";
            keybind = "3";
          }
          {
            action = "logout";
            keybind = "4";
          }
          {
            action = "shutdown";
            keybind = "5";
          }
          {
            action = "rebootToUefi";
            keybind = "6";
          }
          {
            action = "userspaceReboot";
          }
        ];
        colorSchemes = {
          useWallpaperColors = false;
          predefinedScheme = "Tokyo Night";
          darkMode = true;
          schedulingMode = "location";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "fruit-salad";
          syncGsettings = true;
        };
        templates = {
          activeTemplates = [
            {
              id = "btop";
              enabled = true;
            }
            {
              id = "gtk";
              enabled = true;
            }
            {
              id = "yazi";
              enabled = true;
            }
            {
              id = "steam";
              enabled = true;
            }
            {
              id = "discord";
              enabled = true;
            }
            {
              id = "starship";
              enabled = true;
            }
            {
              id = "qt";
              enabled = true;
            }
          ];
          enableUserTheming = false;
        };
        nightLight = {
          enabled = true;
          autoSchedule = true;
          nightTemp = 3500;
          dayTemp = 5700;
        };

        idle = {
          enabled = true;
          screenOffTimeout = 300;
          lockTimeout = 660;
          suspendTimeout = 1800;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "";
          customCommands = "[]";
        };

      };
    };
  };
}
