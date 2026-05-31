{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user.name = "Mark Rossi";
      user.email = "mark.rossi.06@gmail.com";

      init.defaultBranch = "main";
      init.core.editor = "vim";
    };

    lfs.enable = true;
  };
}
