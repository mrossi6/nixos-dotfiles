{
  pkgs,
  username,
  homeDirectory,
  ...
}:
{
  imports = [
    ./fonts.nix
    ./niri.nix
    ./noctalia.nix
  ];
  home = {
    inherit username homeDirectory;
    stateVersion = "25.11";
  };
  home.pointerCursor = {
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 31;

    gtk.enable = false;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "BreezeX-RosePine-Linux";
    XCURSOR_SIZE = "31";
  };
}
