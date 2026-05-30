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

  programs.starship.enable = true;

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "catppuccin"
      "everforest"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Rosé Pine";
        light = "Rosé Pine Dawn";
      };
      vim_mode = true;
      ui_font_size = 18;
      buffer_font_family = "CommitMono";
      buffer_font_size = 16;
    };
  };

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
  home.file.".config/nvim".source = ../../config/nvim;
  home.file.".config/tmux".source = ../../config/tmux;
  home.file.".config/starship".source = ../../config/starship;
}
