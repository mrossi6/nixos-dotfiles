# Zed Configuration

This directory contains the Zed editor configuration matching the keyboard-centric Neovim/tmux workflow.

## Files

- `settings.json` - Main Zed settings (vim mode, theme, editor behavior)
- `keymap.json` - Custom keybindings (Neovim-style, Alt+H/L for tabs, Ctrl+H/J/K/L for panes)

## Deployment

Deploy via GNU stow from the parent dotfiles directory:

```bash
cd ~/dotfiles
stow zed
```

This creates symlinks from `~/.config/zed/` to these config files.

## Configuration Overview

### Tab Navigation
- **Alt+H** - Previous tab (left)
- **Alt+L** - Next tab (right)
- **Space+bn** - Next tab (buffer-style, alternative)
- **Space+bp** - Previous tab (buffer-style, alternative)
- **Space+bd** - Close current tab
- **Space+bl** - Open tab switcher

### Window/Pane Navigation
- **Ctrl+H** - Navigate left pane
- **Ctrl+J** - Navigate down pane
- **Ctrl+K** - Navigate up pane
- **Ctrl+L** - Navigate right pane

### File Operations
- **Space+ff** - Find files (file finder)
- **Space+fw** - Search text in project (workspace search)
- **Space+fb** - Search open buffers/tabs
- **Space+/** - Search in current buffer
- **Space+e** - Toggle project panel
- **Ctrl+S** - Save file

### LSP Operations
- **gd** - Go to definition
- **gr** - Find all references
- **K** - Hover documentation
- **[d** - Previous diagnostic
- **]d** - Next diagnostic
- **Space+ca** - Code actions
- **Space+rn** - Rename symbol
- **Space+f** - Format document

### Diagnostics
- **Space+wd** - Workspace diagnostics
- **Space+xx** - Diagnostics panel

## Key Settings

### Vim Mode
- System clipboard enabled
- Smart case find enabled
- Toggle relative line numbers enabled

### Editor Behavior
- Tab size: 2 spaces
- Line length: 120 characters
- Format on save enabled
- Remove trailing whitespace on save
- Auto-save disabled (manual save with Ctrl+S)
- Vertical scroll margin: 8 lines

### LSP & Code Intelligence
- Rust analyzer configured with clippy checker
- Code actions on import organization enabled
- Inline completions enabled

### Panels
- Project panel (left dock, 300px wide, git status enabled)
- Outline panel (right dock, 300px wide)
- Terminal (bottom dock, 400px tall, zsh shell)
- Tabs with file icons and git status

## Language Server Setup

Install the same language servers as Neovim for consistent behavior:

### Python
```bash
uv tool install basedpyright
uv tool install ruff
```

### Go
```bash
go install golang.org/x/tools/gopls@latest
```

Zed automatically detects these if they're in your PATH.

## Recommended Extensions

Install via `Cmd+Shift+X`:
- HTML/CSS
- Tailwind CSS (if used in projects)
- TOML
- Docker

## Per-Project Configuration

Create `.zed/settings.json` in any project root to override global settings for that project (similar to Neovim's `.nvim.lua`).

## Differences from Neovim

| Feature | Neovim | Zed |
|---------|--------|-----|
| Performance | Warm start (~500ms) | Native (~100ms) |
| Debugging | nvim-dap + UI | DAP support (less mature) |
| Testing | Neotest plugin | Tasks system |
| AI Integration | External (Copilot) | Built-in Claude/Copilot |
| Git Integration | vim-fugitive | Built-in + git blame panel |
| Buffer Navigation | `:bnext`/`:bprev` | `pane::ActivateNextItem` |
| Collaboration | Requires setup | Built-in pair programming |

## Troubleshooting

### Ctrl+H/J/K/L not working for pane navigation
- Verify `vim_mode == normal` context in keybindings
- Check that you're not in insert mode (vim mode only applies in normal mode)
- Try reloading Zed: Cmd+Shift+P → "Reload Window"

### Alt+H/L not switching tabs
- Verify the `Editor` context in keybindings
- Check that tabs are actually open (Alt navigation requires open tabs)
- macOS: If using a window manager that intercepts Alt, use Space+bn/bp instead

### Space+based commands not activating
- Ensure context includes `vim_mode == normal && !menu`
- The 1-second timeout for multi-key sequences is a Zed limitation
- Most-used commands become muscle memory quickly

## Further Reading

- [Zed Documentation](https://zed.dev/docs)
- [Zed Vim Mode](https://zed.dev/docs/vim)
- [Zed Keybindings](https://zed.dev/docs/key-bindings)
