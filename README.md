## 🖥️ System Overview

- **OS**: EndeavourOS (Arch-based)
- **Window Manager**: Hyprland
- **Shell**: Fish with Starship prompt
- **Terminal**: Ghostty
- **Editor**: Neovim (Kickstart-based configuration)
- **Terminal Multiplexer**: tmux with sesh session management
- **Application Launcher**: Rofi
- **Status Bar**: Waybar
- **File Manager**: Thunar/yazi
- **Theme**: Lackluster (consistent across applications)

## 📁 Configuration Structure

### Core Applications

#### 🪟 Hyprland (`hypr/`)

- **Main config**: `hyprland.conf`
- **Features**: Dual layout support (US/Ukrainian), custom window rules, smart gaps
- **Terminal**: Ghostty as default terminal
- **Launcher**: Custom Rofi launcher script

#### 🐚 Fish Shell (`fish/`)

- **Main config**: `config.fish`
- **Features**:
  - Starship prompt integration
  - Zoxide for smart directory jumping
  - Custom aliases (`ss` for sesh-sessions, `cd` aliased to `z`)

#### 🖥️ Terminal & Multiplexing

- **Ghostty** (`ghostty/`)
- **tmux** (`tmux/`): Session management with sesh integration
  - Custom prefix: `Ctrl+Space`
  - Vim-style navigation
  - Lackluster color scheme
  - Smart session switching with fzf

#### 🚀 Session Management (`sesh/`)

- **sesh**: Intelligent tmux session manager
- **Integration**: Bound to `Ctrl+F` in both Fish and tmux
- **Features**: Project detection, zoxide integration, config management

### UI & Theming

#### 🎨 Waybar (`waybar/`)

- **Layout**: Window title (left), workspaces (center), system info (right)
- **Modules**: Language indicator, tray, audio, network, memory, CPU, temperature, clock
- **Style**: Macchiato color scheme with custom CSS.

#### 🔍 Rofi (`rofi/`)

- **Modes**: Applications, run commands, file browser, window switcher
- **Theme**: Type-7 launcher with Papirus icons

#### 🎭 Themes

- **Primary**: Lackluster theme (consistent across Ghostty, tmux, Neovim)
- **Colors**: Muted grays and blues for reduced eye strain
- **Fonts**: JetBrainsMono Nerd Font for consistent typography

### Development Tools

#### 🔧 Development Environment

- **Tmuxinator**: Project-specific tmux session templates
- **Lazygit**: Terminal UI for Git operations

### System Integration

#### 🔔 Notifications (`swaync/`)

- **SwayNC**: Notification daemon for Wayland
- **Custom styling**: Integrated with system theme

## 🚀 Quick Start

### Key Bindings

- `Ctrl + F`: Quick session switcher(works in tmux/ghostty/fish).

#### Hyprland

- `Super + Return`: Open terminal (Ghostty)
- `Super + D`: Application launcher (Rofi)
- `Super + Q`: Close window
- `Super + [1-9]`: Switch workspaces
- `Super + Shift + [1-9]`: Move window to workspace
- `Win + Space`: Toggle keyboard layout (US/Ukrainian)

#### tmux

- `Ctrl + Space`: Prefix key
- `Prefix + |`: Vertical split
- `Prefix + _`: Horizontal split

#### Fish Shell

- `z <directory>`: Smart directory jumping (zoxide)
- `ss`: Session management shortcut

