{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Mark Rossi";
    userEmail = "mark.rossi.06@gmail.com";

    lfs.enable = true;

    extraConfig.init.defaultBranch = "main";
    extraConfig.init.core.editor = "vim";
  };
}
