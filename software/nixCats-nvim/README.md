# nixCats Neovim Configuration

This is a nixCats-based Neovim configuration ported from a Kickstart.nvim setup. It provides a fully reproducible, declarative Neovim environment with all plugins and LSPs managed through Nix.

## Features

- **Fully Declarative**: All plugins, LSPs, and dependencies managed via Nix
- **Reproducible**: Exact same environment across different machines
- **Modular**: Organized into logical categories (UI, LSP, Editor, AI, etc.)
- **Multiple Packages**: Different variants for different use cases
- **No Mason Required**: LSPs installed directly via Nix (works great on NixOS)

## Quick Start

### Try it out

```bash
# Run the configuration directly
nix run .

# Or run the development version with live reloading
nix run .#nixCats-dev
```

### Install locally

```bash
# Clone the repository
git clone <your-repo-url>
cd nixCats-nvim

# Build and run
nix build
./result/bin/nixCats

# Or run directly
nix run .
```

## Available Packages

- **nixCats**: Full configuration with all features
- **nixCats-dev**: Development version with live reloading (`wrapRc = false`)
- **nixCats-minimal**: Minimal configuration with only essential features

## Plugin Categories

The configuration is organized into the following categories:

### Core (`core`)
- plenary-nvim
- nvim-web-devicons  
- guess-indent-nvim

### UI (`ui`)
- snacks-nvim (picker, dashboard, notifications)
- lualine-nvim (statusline)
- kanagawa-nvim (colorscheme)
- lackluster-nvim (alternative colorscheme)
- noice-nvim (command line UI)
- dressing-nvim (better UI elements)

### Completion (`completion`)
- blink-cmp (completion engine)
- luasnip (snippets)
- lazydev-nvim (Lua development)

### LSP (`lsp`)
- nvim-lspconfig
- fidget-nvim (LSP progress)
- nvim-navic (breadcrumbs)

### Treesitter (`treesitter`)
- nvim-treesitter (with all grammars)
- nvim-treesitter-textobjects

### Editor (`editor`)
- flash-nvim (navigation)
- trouble-nvim (diagnostics)
- gitsigns-nvim (git integration)
- diffview-nvim (git diff viewer)
- which-key-nvim (keybinding help)
- mini-nvim (various utilities)
- And many more...

### AI (`ai`)
- copilot-lua
- copilot-chat-nvim
- blink-copilot (Copilot integration with blink.cmp)

### Tools (`tools`)
- harpoon2 (file navigation)
- neo-tree-nvim (file explorer)
- overseer-nvim (task runner)
- conform-nvim (formatting)

### Testing (`testing`)
- neotest (testing framework)
- neotest-python
- nvim-dap (debugging)
- nvim-dap-ui

### Python (`python`)
- Python-specific configurations and tools

## LSP Servers

The following LSP servers are available based on enabled categories:

- **Go** (`go`): gopls, delve
- **Python** (`python`): basedpyright, ruff
- **Web** (`web`): typescript-language-server, prettier
- **Nix** (`nix`): lua-language-server, stylua, nixd
- **Docker** (`docker`): docker-ls, docker-compose-language-service
- **JSON** (`json`): vscode-json-languageserver

## Key Features

### Snacks.nvim Integration
- Smart file picker (`<leader><space>`)
- Buffer management (`<leader>,`)
- Git integration (`<leader>g*`)
- Search and grep (`<leader>s*`)
- Notification system

### LSP Features
- Go to definition/references with Snacks picker
- Code actions (`<leader>ca`)
- Rename (`<leader>cr`)
- Diagnostics (`<leader>cd`)
- Inlay hints toggle (`<leader>uh`)

### Git Integration
- Gitsigns for git status in gutter
- Diffview for reviewing changes
- Lazygit integration via Snacks
- Git blame and browse

### AI Features
- GitHub Copilot integration
- Copilot Chat for AI assistance
- Seamless integration with completion system

## Configuration Structure

```
nixCats-nvim/
├── flake.nix                 # Main Nix configuration
├── init.lua                  # Main Neovim entry point
├── lua/
│   ├── keymaps.lua          # Global keymaps
│   └── myLuaConf/           # Modular configuration
│       ├── ui.lua           # UI plugins
│       ├── completion.lua   # Completion system
│       ├── lsp.lua          # LSP configuration
│       ├── treesitter.lua   # Treesitter setup
│       ├── editor.lua       # Editor enhancements
│       ├── ai.lua           # AI/Copilot setup
│       ├── tools.lua        # Development tools
│       ├── testing.lua      # Testing and debugging
│       └── python.lua       # Python-specific config
└── lua/overseer/template/user/
    └── go_build.lua         # Custom overseer template
```

## Temporarily Disabled Plugins

The following plugins have been temporarily disabled due to Nix overlay issues with custom flake inputs. They can be re-enabled once the overlay system is properly configured:

### Custom Plugins (from flake inputs)
- **blink-copilot** - Copilot integration for blink.cmp (AI category)
- **close-buffers.nvim** - Advanced buffer management (editor category)  
- **statuscol.nvim** - Enhanced status column (editor category)
- **screenkey.nvim** - Show keypresses on screen (tools category)
- **pymple.nvim** - Python development enhancements (python category)
- **python-copy-reference.vim** - Copy Python references (python category)

### Impact
- **AI features**: Copilot still works, but without blink.cmp integration
- **Buffer management**: Basic buffer operations work, advanced close-buffers features disabled
- **Status column**: Using default Neovim status column instead of enhanced version
- **Python development**: Core Python LSP and tools work, some convenience features disabled

### Re-enabling Later
These plugins can be re-enabled by:
1. Fixing the nixCats overlay to properly handle flake inputs
2. Or using `fetchFromGitHub` directly in the Nix configuration
3. Or loading them as git submodules/manual installations
