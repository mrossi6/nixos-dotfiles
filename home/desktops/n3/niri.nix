{ lib, ... }:
{
  programs.zsh = {
    profileExtra = lib.mkAfter ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "''${XDG_VTNR:-0}" -eq 1 ]; then
        exec niri --session
      fi
    '';
  };

  home.file.".config/niri".source = ../../../config/niri;
}
