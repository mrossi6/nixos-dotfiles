{ config, pkgs, ...}: 

{
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "25.11";

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra= ''
      eval "$(starship init zsh)"

      if uwsm check may-start && uwsm select; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };

  # home.file.".config/hypr".source = ./config/hypr;
  # home.file.".config/zed".source = ./config/zed;
}
