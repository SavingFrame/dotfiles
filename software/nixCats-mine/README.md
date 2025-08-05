# NixCats Neovim Configuration

This is a nixCats-based Neovim configuration converted from a lazy.nvim setup. It uses `lze` for lazy loading plugins instead of `packadd` where possible.

## Features

- **Modular plugin system** using nixCats categories
- **Lazy loading** with `lze` instead of traditional `packadd`
- **LSP support** for Go, Python, Lua, JSON, Docker, and Templ
- **Modern UI** with Snacks.nvim, Lualine, and Kanagawa theme
- **Git integration** with Gitsigns and Diffview
- **Completion** with Blink.cmp and optional Copilot support
- **Treesitter** for syntax highlighting
- **Formatting** with Conform.nvim
- **And much more...**

## Plugin Categories

The configuration is organized into categories that can be enabled/disabled:

- `general` - Core utilities (ripgrep, fd, etc.)
- `ui` - UI plugins (Snacks, Lualine, themes, etc.)
- `git` - Git-related plugins
- `editor` - Editor enhancements (Flash, Trouble, etc.)
- `copilot` - GitHub Copilot integration
- `lsp` - Language Server Protocol support
- `treesitter` - Syntax highlighting
- `completion` - Autocompletion
- `format` - Code formatting
- `debug` - Debugging support
- `testing` - Test runners
- `python` - Python-specific tools
- `utils` - Utility plugins
- `fold` - Code folding
- `overseer` - Task runner
- `neo_tree` - File explorer
- `mini` - Mini.nvim plugins
- `which_key` - Key binding help
- `todo_comments` - TODO highlighting

## Usage

### Testing the configuration

```bash
# Test the configuration
nix run .

# Or build it
nix build .
```

### Installing in NixOS

Add to your NixOS configuration:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixcats.url = "path:/etc/nixos/software/lua.nvim-nixcats";
  };

  outputs = { self, nixpkgs, nixcats, ... }: {
    nixosConfigurations.yourhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        {
          environment.systemPackages = [
            nixcats.packages.x86_64-linux.nixCats
          ];
        }
      ];
    };
  };
}
```

### Installing with Home Manager

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixcats.url = "path:/etc/nixos/software/lua.nvim-nixcats";
  };

  outputs = { nixpkgs, home-manager, nixcats, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home.nix
        {
          home.packages = [
            nixcats.packages.x86_64-linux.nixCats
          ];
        }
      ];
    };
  };
}
```

## Key Differences from Original

1. **Plugin Management**: Uses nixCats categories instead of lazy.nvim
2. **Lazy Loading**: Uses `lze` instead of `packadd` where possible
3. **Dependencies**: All plugins and LSPs are managed by Nix
4. **Configuration**: Conditional loading based on nixCats categories
5. **No Mason**: LSPs and tools are provided by Nix instead of Mason

## Customization

To customize the configuration:

1. **Add/Remove Categories**: Edit the `categories` section in `flake.nix`
2. **Add Plugins**: Add them to the appropriate category in `categoryDefinitions`
3. **Modify Plugin Config**: Edit the corresponding file in `lua/plugins/`
4. **Add LSPs**: Add them to `lspsAndRuntimeDeps` and configure in `lua/plugins/lsp.lua`

## Notes

- Commented telescope configuration was not migrated as requested
- Uses `lze` for lazy loading instead of `packadd` where possible
- All dependencies are managed by Nix, no need for Mason or similar tools
- Configuration is modular and can be easily extended or reduced