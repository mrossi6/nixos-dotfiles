{ pkgs, ... }:

{
  fonts.fontconfig = {
    enable = true;
    antialiasing = true;

    hinting = "slight";

    subpixelRendering = "rgb";
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    commit-mono
    work-sans
    ioskeley-mono.term-nf
    symbola
  ];
}
