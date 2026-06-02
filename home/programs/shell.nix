{
  lib,
  nixosFlakeTarget ? null,
  ...
}:
{

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = lib.optionalAttrs (nixosFlakeTarget != null) {
      nd = "nix develop -c $SHELL";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#${nixosFlakeTarget}";
    };
  };

  home.file.".config/starship".source = ../../config/starship;
  home.file.".config/tmux".source = ../../config/tmux;
}
