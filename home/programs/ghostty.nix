{ ... }:
{

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    profileExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  home.file.".config/ghostty".source = ../../config/ghostty;
}
