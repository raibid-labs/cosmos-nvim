-- Slime theme for Neovim
-- Ported from: https://github.com/beengud/theme-slime
-- Author: beengud

local M = {}

M.base_30 = {
  white = '#efefef',
  darker_black = '#1b2020',
  black = '#1e2324', -- nvim bg
  black2 = '#24292a',
  one_bg = '#282e2f',
  one_bg2 = '#293030',
  one_bg3 = '#343b3c',
  grey = '#375d4f',
  grey_fg = '#62706a',
  grey_fg2 = '#6e7573',
  light_grey = '#878f8c',
  red = '#cd6564',
  baby_pink = '#AB6767',
  pink = '#be9296',
  line = '#375d4f', -- for lines like vertsplit
  green = '#AEC199',
  vibrant_green = '#8bac78',
  nord_blue = '#8CAEC1',
  blue = '#6D9CBE',
  yellow = '#fff099',
  sun = '#fabd2f',
  purple = '#B081B9',
  dark_purple = '#9876AA',
  teal = '#80B5B3',
  orange = '#e0ba7d',
  cyan = '#80B5B3',
  statusline_bg = '#282e2f',
  lightbg = '#293030',
  pmenu_bg = '#6D9CBE',
  folder_bg = '#6D9CBE',
}

M.base_16 = {
  base00 = '#1e2324', -- Default Background (editor background)
  base01 = '#24292a', -- Lighter Background (tabs inactive)
  base02 = '#6c516e', -- Selection Background
  base03 = '#6e7573', -- Comments, Invisibles, Line Highlighting
  base04 = '#878f8c', -- Dark Foreground
  base05 = '#e0e0e0', -- Default Foreground (editor foreground)
  base06 = '#bcbebe', -- Light Foreground (sidebar foreground)
  base07 = '#efefef', -- Light Background (terminal white)
  base08 = '#cd6564', -- Variables, XML Tags, Markup Link Text (red)
  base09 = '#e0ba7d', -- Integers, Boolean, Constants (orange)
  base0A = '#fff099', -- Classes, Markup Bold, Search Text Background (yellow)
  base0B = '#AEC199', -- Strings, Inherited Class, Markup Code (green)
  base0C = '#80B5B3', -- Support, Regular Expressions, Escape Characters (cyan)
  base0D = '#6D9CBE', -- Functions, Methods, Attribute IDs, Headings (blue)
  base0E = '#B081B9', -- Keywords, Storage, Selector, Markup Italic (magenta)
  base0F = '#9876AA', -- Deprecated, Opening/Closing Embedded Language Tags (dark purple)
}

M.type = 'dark'

M.polish_hl = {
  -- Cursor and Visual
  Cursor = { fg = '#1e2324', bg = '#a8df5a' },
  Visual = { bg = '#6c516e' },
  Search = { fg = '#1e2324', bg = '#fff099' },
  IncSearch = { fg = '#1e2324', bg = '#a8df5a' },
  CursorLine = { bg = '#293030' },

  -- Statusline
  StatusLine = { fg = '#62706a', bg = '#282e2f' },
  StatusLineNC = { fg = '#62706a', bg = '#282e2f' },

  -- TreeSitter highlights (matching VS Code theme syntax)
  ['@variable'] = { fg = '#e1e2de' },
  ['@variable.builtin'] = { fg = '#B081B9' },
  ['@function'] = { fg = '#6D9CBE' },
  ['@function.builtin'] = { fg = '#80B5B3' },
  ['@keyword'] = { fg = '#AB6767' },
  ['@operator'] = { fg = '#80B5B3' },
  ['@type'] = { fg = '#d6c05d' },
  ['@type.builtin'] = { fg = '#d6c05d' },
  ['@string'] = { fg = '#AEC199' },
  ['@number'] = { fg = '#B081B9' },
  ['@boolean'] = { fg = '#B081B9' },
  ['@constant'] = { fg = '#9876AA' },
  ['@comment'] = { fg = '#6e7573', italic = true },
  ['@tag'] = { fg = '#6D9CBE' },
  ['@tag.attribute'] = { fg = '#80B5B3' },
  ['@constructor'] = { fg = '#d6c05d' },
  ['@field'] = { fg = '#9FB3C2' },
  ['@property'] = { fg = '#9FB3C2' },

  -- Git signs
  GitSignsAdd = { fg = '#8bac78' },
  GitSignsChange = { fg = '#fabd2f' },
  GitSignsDelete = { fg = '#c05557' },

  -- Telescope
  TelescopeBorder = { fg = '#375d4f', bg = '#1b2020' },
  TelescopeNormal = { fg = '#e0e0e0', bg = '#1b2020' },
  TelescopeSelection = { fg = '#1e2324', bg = '#a8df5a' },
  TelescopeMatching = { fg = '#80B5B3' },

  -- NvimTree
  NvimTreeNormal = { fg = '#bcbebe', bg = '#1b2020' },
  NvimTreeFolderIcon = { fg = '#6D9CBE' },
  NvimTreeFolderName = { fg = '#6D9CBE' },
  NvimTreeOpenedFolderName = { fg = '#80B5B3' },
  NvimTreeRootFolder = { fg = '#B081B9', bold = true },
  NvimTreeGitDirty = { fg = '#fabd2f' },
  NvimTreeGitNew = { fg = '#8bac78' },
  NvimTreeGitDeleted = { fg = '#c05557' },
}

M = require('base46').override_theme(M, 'slime')

return M
