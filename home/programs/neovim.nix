{ ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
  };
  home.file.".config/nvim".source = ../../config/nvim;
}
