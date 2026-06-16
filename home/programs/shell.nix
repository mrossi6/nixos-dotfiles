{
  lib,
  pkgs,
  nixosFlakeTarget ? null,
  ...
}:
{

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.starship.enable = true;

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "Space";
    extraConfig = ''
      set-option -g status-style "bg=#414868,fg=#a9b1d6"

      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R

      bind-key | split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Vi-style selection and copy in copy mode
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel
    '';
  };

  programs.sesh.enable = true;
  programs.fzf.tmux.enableShellIntegration = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = lib.optionalAttrs (nixosFlakeTarget != null) {
      nd = "nix develop -c $SHELL";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#${nixosFlakeTarget}";
    };
  };

  home.file.".config/starship".source = ../../config/starship;
  # home.file.".config/tmux".source = ../../config/tmux;
}
