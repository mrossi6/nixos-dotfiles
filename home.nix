{ config, pkgs, ...}: 

{
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "25.11";

  programs.starship.enable = true;

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "rust" ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
    vim_mode = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    profileExtra = ''
      eval "$(starship init zsh)"

      if uwsm check may-start && uwsm select; then
        exec uwsm start hyprland.desktop
      fi
    '';
  };

  # home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/ghostty".source = ./config/ghostty;
  home.file.".config/starship".source = ./config/starship;

  home.packages = with pkgs; [
    commit-mono
  ];

  fonts.fontconfig.enable = true;
}
