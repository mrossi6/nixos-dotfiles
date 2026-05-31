{ ... }:
{

  programs.starship.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    profileExtra = ''
      eval "$(starship init zsh)"
    '';
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#twist";
    };
  };

  home.file.".config/starship".source = ../../config/starship;
  home.file.".config/tmux".source = ../../config/tmux;
}
