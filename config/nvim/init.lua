-- =============================================================================
-- NEOVIM CONFIG - Keyboard-centric, Minimal, Focused
-- =============================================================================

-- Use leader as space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- BOOTSTRAP LAZY.NVIM
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- CORE SETTINGS
-- =============================================================================

-- Appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true

-- Editing
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Behavior
vim.opt.undofile = true
vim.opt.backspace = "indent,eol,start"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true

-- =============================================================================
-- KEYBINDINGS - Essential Mappings
-- =============================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Buffers (fast switching between open files)
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprev<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)
keymap("n", "<leader>bl", ":buffers<CR>", opts)

-- Clear search highlight
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-- Save file
keymap("n", "<C-s>", ":w<CR>", opts)

-- =============================================================================
-- PLUGINS - Define all plugins here
-- =============================================================================

local plugins = {
  -- Theme (Catppuccin)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = true
  },

  -- Tokyo Night theme family
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = true,
  },

  -- Nord theme family
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
    lazy = true,
  },

  -- Monokai Pro
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    lazy = true,
  },

  -- Gruvbox Material
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = true,
  },

  -- Fuzzy finder (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      -- Configure Telescope to search hidden files
      telescope.setup({
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
      })

      keymap("n", "<leader>ff", builtin.find_files, { noremap = true })
      keymap("n", "<leader>fw", builtin.live_grep, { noremap = true })
      keymap("n", "<leader>fW", function()
        builtin.live_grep({ additional_args = { "--hidden", "--no-ignore", "--fixed-strings" } })
      end, { noremap = true, desc = "Grep (literal)" })
      keymap("n", "<leader>fb", builtin.buffers, { noremap = true })
      keymap("n", "<leader>fh", builtin.help_tags, { noremap = true })
      keymap("n", "<leader>/", builtin.current_buffer_fuzzy_find, { noremap = true })
    end,
  },

  -- File explorer (NvimTree)
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
      keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    end,
  },

  -- Status line (Lualine)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },
      })
    end,
  },

  -- Treesitter (better syntax highlighting)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "bash", "kdl" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Git integration (Fugitive)
  {
    "tpope/vim-fugitive",
  },

  -- Git link to remote (GitHub/GitLab/etc)
  {
    "linrongbin16/gitlinker.nvim",
    config = function()
      require("gitlinker").setup()
      -- Open current line on GitHub in browser
      keymap("n", "<leader>gb", "<cmd>GitLink<CR>", { noremap = true, desc = "Git Browse (open in browser)" })
      -- Copy GitHub URL to clipboard
      keymap("n", "<leader>gy", "<cmd>GitLink!<CR>", { noremap = true, desc = "Git Yank (copy URL)" })
      -- Visual mode - open selection on GitHub
      keymap("v", "<leader>gb", "<cmd>GitLink<CR>", { noremap = true, desc = "Git Browse (open in browser)" })
      -- Visual mode - copy selection URL to clipboard
      keymap("v", "<leader>gy", "<cmd>GitLink!<CR>", { noremap = true, desc = "Git Yank (copy URL)" })
    end,
  },

  -- Comment toggle (gcc to toggle comment)
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },

  -- Debug Adapter Protocol (DAP)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",  -- Required for dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup()

      -- Helper function to get Python path for current project
      local function get_python_path()
        -- Look for .venv/bin/python in project root
        local cwd = vim.fn.getcwd()
        local venv_python = cwd .. "/.venv/bin/python"

        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- Fallback to system python
        return "python3"
      end

      -- Setup DAP adapter to use uvx debugpy
      dap.adapters.python = {
        type = "executable",
        command = "uvx",
        args = { "--from", "debugpy", "python", "-m", "debugpy.adapter" },
      }

      -- Override pythonPath to use project's Python
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return get_python_path()
          end,
          justMyCode = true,  -- Don't step into library code
        },
        {
          type = "python",
          request = "launch",
          name = "Launch file with args",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
          pythonPath = function()
            return get_python_path()
          end,
          justMyCode = true,  -- Don't step into library code
        },
      }

      -- Auto-open/close UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      -- Keybindings
      keymap("n", "<leader>db", dap.toggle_breakpoint, { noremap = true, desc = "Toggle Breakpoint" })
      keymap("n", "<leader>dc", dap.continue, { noremap = true, desc = "Continue" })
      keymap("n", "<leader>do", dap.step_over, { noremap = true, desc = "Step Over" })
      keymap("n", "<leader>di", dap.step_into, { noremap = true, desc = "Step Into" })
      keymap("n", "<leader>du", dapui.toggle, { noremap = true, desc = "Toggle UI" })
    end,
  },

  -- Test runner (Neotest)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- Helper function to get Python path for current project
      local function get_python_path()
        -- Look for .venv/bin/python in project root
        local cwd = vim.fn.getcwd()
        local venv_python = cwd .. "/.venv/bin/python"

        if vim.fn.executable(venv_python) == 1 then
          return venv_python
        end

        -- Fallback to system python
        return "python3"
      end

      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            -- Use uv to run pytest with the correct environment
            runner = "pytest",
            python = function()
              return get_python_path()
            end,
            args = { "-vv" },
            -- Use uv run to execute pytest in the project's environment
            pytest_discover_instances = true,
            -- DAP configuration for debugging tests
            dap = {
              justMyCode = true,  -- Don't step into pytest/library code
            },
          }),
        },
      })

      -- Keybindings
      keymap("n", "<leader>tt", function() require("neotest").run.run() end, { noremap = true, desc = "Test Nearest" })
      keymap("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { noremap = true, desc = "Test File" })
      keymap("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, { noremap = true, desc = "Debug Test" })
      keymap("n", "<leader>ts", function() require("neotest").summary.toggle() end, { noremap = true, desc = "Test Summary" })
      keymap("n", "<leader>to", function() require("neotest").output_panel.toggle() end, { noremap = true, desc = "Test Output" })
    end,
  },

  -- Problem/Diagnostics viewer (Trouble)
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },

  -- LSP Configuration (Neovim 0.11+ native API)
  -- Note: You still need to install language servers separately:
  --   brew install lua-language-server
  --   npm install -g typescript typescript-language-server
  -- No plugin needed - uses built-in vim.lsp.config and vim.lsp.enable

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.complete(),  -- Changed from Ctrl+Space to avoid tmux conflict
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },  -- Prioritize LSP suggestions
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500, keyword_length = 3 },  -- Only after 3 chars
          { name = "path", priority = 250 },
        }),
        -- Show more details in completion menu
        formatting = {
          format = function(entry, vim_item)
            -- Show source in completion menu
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snip]",
              buffer = "[Buf]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        -- Better completion behavior
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        experimental = {
          ghost_text = true,  -- Show preview of completion as you type
        },
      })
    end,
  },
}

-- Load plugins with lazy.nvim
require("lazy").setup(plugins, {
  install = { colorscheme = { "catppuccin" } },
})

-- =============================================================================
-- COLORSCHEME - Set active theme
-- =============================================================================

-- Read theme from file, fallback to catppuccin-mocha if not set
local theme_file = vim.fn.expand("~/.config/nvim/theme")
local theme = "catppuccin-mocha"  -- default
local background = nil

if vim.fn.filereadable(theme_file) == 1 then
  local file = io.open(theme_file, "r")
  if file then
    local line = file:read("*l")
    file:close()

    if line then
      -- Parse "colorscheme background" format
      local parts = vim.split(line, " ")
      theme = parts[1] or theme
      background = parts[2]  -- may be nil
    end
  end
end

-- Set background if specified (for themes like gruvbox that need it)
if background then
  vim.o.background = background
end

vim.cmd.colorscheme(theme)

-- =============================================================================
-- LSP CONFIGURATION (Neovim 0.11+ Native API)
-- =============================================================================

-- Get capabilities from nvim-cmp to advertise to LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup keybindings when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local lsp_opts = { noremap = true, silent = true, buffer = bufnr }

    -- Custom keybindings (supplement the default gra, grn, grr, etc.)
    keymap("n", "gd", vim.lsp.buf.definition, lsp_opts)
    keymap("n", "K", vim.lsp.buf.hover, lsp_opts)
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, lsp_opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, lsp_opts)
    keymap("n", "<leader>f", vim.lsp.buf.format, lsp_opts)

    -- Signature help (show function parameters)
    keymap("i", "<C-k>", vim.lsp.buf.signature_help, lsp_opts)

    -- Note: Native completion disabled in favor of nvim-cmp
    -- if client and client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end
  end,
})

-- Helper function to find Python LSP tool (ruff, basedpyright, etc.)
local function find_python_tool(tool_name, server_arg)
  -- Check common locations for the tool
  local locations = {
    vim.fn.expand("~/.local/bin/" .. tool_name),
    "/usr/local/bin/" .. tool_name,
    "/usr/bin/" .. tool_name,
  }

  for _, path in ipairs(locations) do
    if vim.fn.executable(path) == 1 then
      return { path, server_arg }
    end
  end

  -- If not found, try using uv tool run as a fallback
  if vim.fn.executable("uv") == 1 then
    return { "uv", "tool", "run", tool_name, server_arg }
  end

  return nil
end

-- Configure and start language servers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(args)
    local bufnr = args.buf
    local root_dir = vim.fs.root(bufnr, { "pyproject.toml", "setup.py", ".git" })

    -- Start Ruff (linting/formatting)
    local ruff_cmd = find_python_tool("ruff", "server")
    if ruff_cmd then
      vim.lsp.start({
        name = "ruff",
        cmd = ruff_cmd,
        root_dir = root_dir,
        capabilities = capabilities,
      }, { bufnr = bufnr })
    end

    -- Start basedpyright (type checking)
    local basedpyright_cmd = find_python_tool("basedpyright-langserver", "--stdio")
    if basedpyright_cmd then
      vim.lsp.start({
        name = "basedpyright",
        cmd = basedpyright_cmd,
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              autoImportCompletions = true
            },
          },
        },
      }, { bufnr = bufnr })
    end
  end,
})
