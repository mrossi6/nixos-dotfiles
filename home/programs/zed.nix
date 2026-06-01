{ ... }:

{
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
    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          alt-h = "pane::ActivatePreviousItem";
          alt-l = "pane::ActivateNextItem";
        };
      }
      {
        context = "vim_mode == normal && !menu";
        bindings = {
          "space b n" = "pane::ActivateNextItem";
          "space b p" = "pane::ActivatePreviousItem";
          "space b d" = "pane::CloseActiveItem";
          "space b l" = "tab_switcher::Toggle";
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "space f f" = "file_finder::Toggle";
          "space f w" = "pane::DeploySearch";
          "space f b" = "tab_switcher::Toggle";
          "space e" = "workspace::ToggleLeftDock";
          "space s v" = "pane::SplitAndMoveRight";
          "space s h" = "pane::SplitDown";
          "ctrl-s" = "workspace::Save";
        };
      }
    ];
  };

}
