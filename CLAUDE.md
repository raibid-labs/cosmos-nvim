# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration called **cosmos-nvim**, a Spacemacs-inspired setup with a layer-based architecture. It provides a VSCode-like experience with Spacemacs keybindings and Vim text objects. The leader key is the spacebar.

**Repository Fork Chain**:
- Original: https://github.com/yetone/cosmos-nvim
- MacBook M3: https://github.com/beengud/cosmos-nvim
- **NVIDIA DGX Spark (this fork)**: https://github.com/raibid-labs/cosmos-nvim

**System**: NVIDIA DGX Spark with Linux (Ubuntu/Debian-based)

## Requirements

- **Neovim 0.8+** (required)
- **Nerd Fonts** (for icons)
- **ripgrep** (for file searching)
- **Chafa** (for GIF rendering, optional: `sudo apt install chafa`)
- **Git** (for version control and plugin management)

### Installation on DGX Spark (Linux)

```bash
# Install Neovim (if not already installed)
sudo apt update
sudo apt install neovim

# Install ripgrep
sudo apt install ripgrep

# Install Chafa (optional, for GIF rendering)
sudo apt install chafa

# Clone this repository
git clone https://github.com/raibid-labs/cosmos-nvim.git ~/raibid-labs/cosmos-nvim

# Create symlink to Neovim config directory
ln -sf ~/raibid-labs/cosmos-nvim ~/.config/nvim

# Create user configuration file
cp ~/.config/nvim/.cosmos-nvim.sample.lua ~/.cosmos-nvim.lua

# Launch Neovim (plugins will be installed automatically)
nvim
```

## Architecture

### Core Structure

```
~/.config/nvim/
├── init.lua                    # Entry point, loads core
├── lua/
│   ├── core/
│   │   ├── init.lua           # Loads cosmos.startup()
│   │   ├── cosmos.lua         # Layer system orchestration
│   │   ├── utils.lua          # Helper functions
│   │   ├── options.lua        # Vim options
│   │   ├── keymappings.lua    # Key bindings
│   │   ├── functions.lua      # Custom functions
│   │   └── settings.lua       # Global settings
│   └── layers/                # Modular feature layers
│       ├── ui/                # UI and theming
│       ├── editor/            # Editor features
│       ├── completion/        # Auto-completion
│       ├── git/               # Git integration
│       └── devops/            # DevOps tools
└── colorschemes/              # Theme files
```

### Layer System

The configuration uses a **Spacemacs-style layer system**. Each layer is a self-contained module with:

- `plugins.lua` - Plugin declarations
- `configs.lua` - Plugin configurations
- `settings.lua` - Layer-specific vim settings
- `keymappings.lua` - Layer keybindings
- `options.lua` - Configurable options
- `functions.lua` - Helper functions (optional)

**Available Layers:**
- `ui` - Interface, themes, statusline, file tree
- `editor` - Editing features, motions, text objects
- `completion` - Auto-completion with LSP support
- `git` - Git integration (fugitive, gitsigns)
- `devops` - DevOps tools

### User Configuration

Users customize the config via `~/.cosmos-nvim.lua` (shortcut: `<leader>fed`):

```lua
local cosmos = require('core.cosmos')

return {
  layers = {
    'editor',
    'git',
    {
      'ui',
      theme = 'tokyonight',              -- Optional theme
      enable_beacon = false,             -- Layer-specific options
      enable_smooth_scrolling = false,
    },
    {
      'completion',
      tab_complete_copilot_first = false,
    },
  },
  options = {
    -- python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python',
  },
  before_setup = function()
    -- cosmos.add_plugin('wakatime/vim-wakatime')
  end,
  after_setup = function()
    -- cosmos.add_leader_keymapping('n|aw', { '<cmd>WakaTimeToday<cr>', name = 'WakaTime Today' })
  end,
}
```

## Common Commands

### Development

```bash
# Lint Lua code
make luacheck

# Check code style
make stylecheck

# Fix code style
make stylefix
```

### Docker (for testing/development)

```bash
# Build base image
make build-base-img

# Build full image
make build-img

# Build stylua image
make build-stylua-img
```

### LSP Installation

Within Neovim, install language servers using Mason:

```vim
:MasonInstall <lsp-server-name>
" Example: :MasonInstall pyright
```

## Key Concepts

### Layer Loading Process

1. `init.lua` → `require('core')`
2. `core/init.lua` → `cosmos.startup()`
3. `cosmos.lua` orchestrates:
   - Loads user config from `~/.cosmos-nvim.lua`
   - Fills layer options from `layers/*/options.lua`
   - Executes `layers/*/settings.lua`
   - Loads plugins from each layer
   - Applies keymappings with which-key integration

### Plugin Management

- Uses **lazy.nvim** for plugin management
- Plugins are declared in layer `plugins.lua` files
- Configurations are in layer `configs.lua` files
- The cosmos API provides:
  - `cosmos.add_plugin(name, opts)` - Add plugins
  - `cosmos.add_leader_keymapping(shortcut, opts)` - Add leader keybindings

### Theming

- Themes are in `lua/layers/ui/themes/`
- Theme structure uses `base_30` and `base_16` color schemes
- Inspired by NvChad/base46 color system
- Preview themes: `<leader>tp`
- Configure in `~/.cosmos-nvim.lua` under UI layer options

### Integration Points

- **LSP**: nvim-lspconfig, lspsaga, lspfuzzy
- **Telescope**: Fuzzy finder like Spacemacs ivy/helm
- **Which-key**: Shows available keybindings after leader
- **Tree-sitter**: Syntax highlighting
- **Git**: fugitive, gitsigns

## Coding Guidelines

### When Adding Features

1. **Determine the appropriate layer** (or create a new one in `lua/layers/`)
2. **Follow layer structure**:
   - Add plugins to `plugins.lua`
   - Configure in `configs.lua`
   - Add keymappings to `keymappings.lua`
   - Document options in `options.lua`
3. **Use cosmos API** for registering plugins and keymappings
4. **Test with minimal config** before integrating

### When Modifying Themes

1. Themes must define both `base_30` and `base_16` color palettes
2. Follow the NvChad color scheme structure
3. Test with multiple UI elements (statusline, tree, telescope, etc.)

### File Organization

- **Keep layer files focused** - each layer handles one concern
- **Settings in settings.lua** - vim.opt/vim.g configurations
- **Keymappings in keymappings.lua** - with layer name annotation
- **Utils in functions.lua** or `core/utils.lua` for global utilities

## Important Notes

- The configuration expects `~/.cosmos-nvim.lua` for user customization
- Leader keymappings automatically get layer annotations (e.g., "[ui]")
- The layer system allows enabling/disabling features by layer
- Uses lazy loading for performance
- Compatible only with Neovim 0.8+

## Troubleshooting

### "lazy.nvim not found" or plugin loading issues

**Symptom**: Neovim fails to load with errors about lazy.nvim or plugins not being found.

**Common Causes**:
1. **Broken symlink**: The `~/.config/nvim` symlink may be pointing to the wrong location
2. **Missing user config**: The `~/.cosmos-nvim.lua` file doesn't exist
3. **Permission issues**: Plugin directories don't have proper permissions

**Solutions**:

```bash
# 1. Verify symlink is correct
ls -la ~/.config/nvim
# Should show: ~/.config/nvim -> /home/beengud/raibid-labs/cosmos-nvim

# 2. Fix broken symlink
rm ~/.config/nvim
ln -sf ~/raibid-labs/cosmos-nvim ~/.config/nvim

# 3. Create user config if missing
cp ~/.config/nvim/.cosmos-nvim.sample.lua ~/.cosmos-nvim.lua

# 4. Check lazy.nvim installation
ls -la ~/.local/share/nvim/lazy/lazy.nvim

# 5. If lazy.nvim is missing, it will auto-install on first launch
# Just launch nvim and wait for installation to complete
nvim

# 6. If issues persist, remove plugin cache and reinstall
rm -rf ~/.local/share/nvim/lazy
nvim  # Will reinstall all plugins
```

### Plugin installation fails

**Symptom**: Plugins fail to install or update.

**Solution**:
```bash
# Ensure git is installed
git --version

# Check internet connectivity
ping -c 3 github.com

# Clear lazy.nvim lock file
rm ~/.config/nvim/lazy-lock.json

# Relaunch and sync
nvim +Lazy
# Press 'S' to sync all plugins
```

### LSP servers not working

**Symptom**: Language servers don't provide completions or diagnostics.

**Solution**:
```vim
" Inside Neovim
:checkhealth lsp
:MasonInstall <language-server>
" Example: :MasonInstall pyright lua-language-server
```

## DGX Spark Specific Notes

- This configuration is optimized for development on NVIDIA DGX Spark systems
- For CUDA development, install relevant LSP servers: `clangd`, `cmake-language-server`
- Python development may require setting `python3_host_prog` in `~/.cosmos-nvim.lua`
- For maximum performance, ensure Neovim is using the system's GPU-optimized libraries
