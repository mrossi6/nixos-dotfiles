{ inputs, pkgs, ... }:
{
  imports = [
    ../desktops/n3
    ../programs/emacs.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/shell.nix
    ../programs/yazi.nix
    ../programs/zed.nix
    ../programs/zen-browser.nix
    inputs.zen-browser.homeModules.default
    inputs.noctalia.homeModules.default
  ];

  home.file.".config/ghostty".source = ../../config/ghostty;
  programs.discord.enable = true;
  programs.foliate.enable = true;
}
