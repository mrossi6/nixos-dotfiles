{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };

      vim.extraPlugins = {
        aerial = {
          package = pkgs.vimPlugins.aerial-nvim;
          setup = "require('aerial').setup {}";
        };

        harpoon = {
          package = pkgs.vimPlugins.harpoon;
          setup = "require('harpoon').setup{}";
          after = [ "aerial" ];
        };
      };
    };
  };
}
