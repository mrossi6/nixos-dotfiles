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

      vim.theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };

      vim.lsp = {
        formatOnSave = true;
        inlayHints.enable = true;
        lspsaga.enable = true;
      };

      vim.visuals.nvim-cursorline.enable = true;

      vim.opts.tabstop = 2;
      vim.opts.shiftwidth = 2;
      vim.opts.expandtab = true;

      vim.searchCase = "ignore";
      vim.undoFile.enable = true;
      vim.clipboard.registers = "unnamedplus";

      vim.globals.mapleader = " ";
      vim.globals.maplocalleader = " ";
      vim.keymaps = [
        {
          key = "<leader>ff";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope fd<CR>";
        }
        {
          key = "<leader>fb";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope buffers<CR>";
        }
        {
          key = "<leader>fw";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope live_grep<CR>";
        }
        {
          key = "<leader>fh";
          mode = "n";
          silent = true;
          action = "<cmd>Telescope help_tags<CR>";
        }
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = "<cmd>NvimTreeToggle<CR>";
        }
      ];

      vim.extraPlugins = {
        aerial = {
          package = pkgs.vimPlugins.aerial-nvim;
          setup = "require('aerial').setup {}";
        };

        nvim-colorizer = {
          package = pkgs.vimPlugins.nvim-colorizer-lua;
          setup = "require('colorizer').setup {}";
        };

        harpoon = {
          package = pkgs.vimPlugins.harpoon;
          setup = "require('harpoon').setup {}";
          after = [ "aerial" ];
        };

        lualine-nvim = {
          package = pkgs.vimPlugins.lualine-nvim;
          setup = "require('lualine').setup {}";
          after = [ "nvim-web-devicons" ];
        };

        nvim-web-devicons = {
          package = pkgs.vimPlugins.nvim-web-devicons;
          setup = "require('nvim-web-devicons').setup {}";
        };

        nvim-tree = {
          package = pkgs.vimPlugins.nvim-tree-lua;
          setup = "require('nvim-tree').setup {}";
          after = [ "nvim-web-devicons" ];
        };

        telescope = {
          package = pkgs.vimPlugins.telescope-nvim;
          setup = ''
            require('telescope').setup {
              defaults = {
                file_ignore_patterns = { "^.git/" },  -- Still ignore .git directory
              },
              pickers = {
                find_files = {
                  hidden = true,  -- Show hidden files/directories
                },
                live_grep = {
                  additional_args = function()
                    return { "--hidden", "--no-ignore" }  -- Search in hidden files and respect no .gitignore
                  end,
                },
              },
            }
          '';
        };

        treesitter-nvim = {
          package = pkgs.vimPlugins.treesitter-modules-nvim;
          setup = ''
            require('nvim-treesitter.config').setup {
              ensure_installed = { 'lua', 'python', 'javascript', 'typescript', 'html', 'css', 'bash', 'kdl' }
            }
          '';
        };

      };
    };
  };
}
