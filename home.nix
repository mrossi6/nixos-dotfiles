{ config, pkgs, ...}: 

{

  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "25.11";
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      if uwsm check may-start && uwsm select; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };
}
