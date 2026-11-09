{ lib, pkgs, ... }:


{
  programs.noctalia = {
    enable = true;
    settings = ../../../config/noctalia/noctalia-config.toml;
  };

  # programs.umbriel = {
  #   settings = {
  #     general.autostart = [ "noctalia" ];
  #     layout.gap = 5;
  #     input.keyboard.layout = "us";
  #     keybinds = {
  #       "Mod+T" = "spawn ghostty";
  #       "Mod+Q" = "window-close";
  #       "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
  #     };
  #   };
  # };
}
