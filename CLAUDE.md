# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration called **cosmos-nvim**, a Spacemacs-inspired setup with a layer-based architecture. It provides a VSCode-like experience with Spacemacs keybindings and Vim text objects. The leader key is the spacebar.

**Repository**: Based on https://github.com/yetone/cosmos-nvim

## Requirements

- **Neovim 0.8+** (required)
- **Nerd Fonts** (for icons)
- **ripgrep** (for file searching)
- **Chafa** (for GIF rendering, optional: `brew install chafa`)

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
