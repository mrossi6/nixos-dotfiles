{ inputs, ... }:
{
  imports = [
    ../default.nix
    ../modules/common.nix
    ../modules/darwin.nix

    inputs.paneru.homeModules.paneru
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    profileExtra = ''
      eval "$(starship init zsh)"
    '';
    shellAliases = {
      hms = "home-manager switch --flake '/Users/markrossi/repos/mirrors/nixos-dotfiles#markrossi@work-mac'";
    };
  };

  services.paneru = {
    enable = true;
    settings = {
      options = {
        focus_follows_mouse = false;
        mouse_follows_focus = true;
        preset_column_widths = [
          0.25
          0.33
          0.5
          0.66
          0.75
          0.8
        ];
        border_active_window = true;
        border_color = "#679D6B";
        border_width = 1.0;

        swipe_gesture_fingers = 4;

        animation_speed = 50;
      };

      bindings = {
        quit = "ctrl + alt - q";

        window_focus_west = "cmd - h";
        window_focus_east = "cmd - l";
        window_focus_north = "cmd - k";
        window_focus_south = "cmd - j";

        window_swap_west = "cmd + alt - h";
        window_swap_east = "cmd + alt - l";
        window_swap_north = "cmd + alt - k";
        window_swap_south = "cmd + alt - j";

        window_center = "alt - c";
        window_resize = "alt - r";
        window_shrink = "alt + shift - r";

        window_fullwidth = "alt - f";
        window_manage = "alt - v";

        window_stack = "alt - ]";
        window_unstack = "alt + shift - ]";

        window_equalize = "alt + shift - e";
      };
    };
  };
}
