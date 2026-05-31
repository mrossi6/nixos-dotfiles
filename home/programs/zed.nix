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
  };

}
