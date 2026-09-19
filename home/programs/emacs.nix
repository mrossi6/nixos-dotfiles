{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };
  home.file.".config/doom".source = ../../config/doom;
}
