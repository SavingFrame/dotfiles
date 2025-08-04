{
  description = "My nixCats neovim config - ported from lua.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    
    # Plugin inputs for plugins not in nixpkgs
    "plugins-blink-copilot" = {
      url = "github:fang2hou/blink-copilot";
      flake = false;
    };
    "plugins-screenkey" = {
      url = "github:NStefan002/screenkey.nvim";
      flake = false;
    };
    "plugins-pymple" = {
      url = "github:alexpasmantier/pymple.nvim";
      flake = false;
    };
    "plugins-python-copy-reference" = {
      url = "github:ranelpadon/python-copy-reference.vim";
      flake = false;
    };
    "plugins-statuscol" = {
      url = "github:luukvbaal/statuscol.nvim";
      flake = false;
    };
    "plugins-close-buffers" = {
      url = "github:kazhala/close-buffers.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    inherit (inputs.nixCats) utils;
    luaPath = ./.;
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    
    extra_pkg_config = {
      allowUnfree = true;
    };

    dependencyOverlays = [
      (utils.standardPluginOverlay inputs)
    ];

    categoryDefinitions = { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef: {
      
      # LSPs and runtime dependencies
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          ripgrep
          fd
          git
          lazygit
          universal-ctags
        ];
        
        go = with pkgs; [
          gopls
          gotools
          go-tools
          delve  # for debugging
        ];
        
        python = with pkgs; [
          basedpyright
          ruff
          python3
        ];
        
        web = with pkgs; [
          nodejs
          nodePackages.typescript-language-server
          nodePackages.prettier
        ];
        
        nix = with pkgs; [
          lua-language-server
          stylua
          nixd
          nil
        ];
        
        docker = with pkgs; [
          docker-ls
          docker-compose-language-service
        ];
        
        json = with pkgs; [
          nodePackages.vscode-json-languageserver
        ];
        
        format = with pkgs; [
          stylua
          nodePackages.prettier
        ];
      };

      # Startup plugins - loaded immediately
      startupPlugins = {
        core = with pkgs.vimPlugins; [
          # Essential plugins that need to load early
          plenary-nvim
          nvim-web-devicons
          guess-indent-nvim
        ];
        
        ui = with pkgs.vimPlugins; [
          # UI plugins
          snacks-nvim
          lualine-nvim
          noice-nvim
          nui-nvim
          nvim-notify
          kanagawa-nvim
          lackluster-nvim
          dressing-nvim
        ];
        
        completion = with pkgs.vimPlugins; [
          # Completion system
          blink-cmp
          luasnip
          lazydev-nvim
        ];
        
        lsp = with pkgs.vimPlugins; [
          # LSP core
          nvim-lspconfig
        ];
        
        treesitter = with pkgs.vimPlugins; [
          # Treesitter with all grammars
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
        ];
      };

      # Optional plugins - loaded on demand
      optionalPlugins = {
        editor = with pkgs.vimPlugins; [
          # Editor enhancements
          flash-nvim
          trouble-nvim
          gitsigns-nvim
          diffview-nvim
          undotree
          treesj
          grug-far-nvim
          which-key-nvim
          todo-comments-nvim
          mini-nvim
          vim-tmux-navigator
          marks-nvim
          nvim-ufo
          promise-async
          vim-python-pep8-indent
          # Note: close-buffers and statuscol temporarily removed due to overlay issues
        ];
        
        ai = with pkgs.vimPlugins; [
          # AI/Copilot
          copilot-lua
          copilot-vim
          CopilotChat-nvim
          # Note: blink-copilot temporarily removed due to overlay issues
        ];
        

        testing = with pkgs.vimPlugins; [
          # Testing
          neotest
          neotest-python
          nvim-dap
          nvim-dap-ui
          nvim-dap-go
          mason-nvim-dap-nvim
        ];
        
        python = with pkgs.vimPlugins; [
          # Python specific
          SchemaStore-nvim
          # Note: pymple and python-copy-reference temporarily removed due to overlay issues
        ];
        
        tools = with pkgs.vimPlugins; [
          # Development tools
          harpoon2
          overseer-nvim
          neo-tree-nvim
          conform-nvim
          persistence-nvim
          # Note: screenkey temporarily removed due to overlay issues
        ];

        lsp = with pkgs.vimPlugins; [
          fidget-nvim
          nvim-navic
          ];
      };

      # Shared libraries
      sharedLibraries = {
        general = with pkgs; [
          # Add any shared libraries needed
        ];
      };

      # Environment variables
      environmentVariables = {
        general = {
          EDITOR = "nvim";
        };
      };

      # Python packages
      python3.libraries = {
        python = (ps: with ps; [
          # Add Python packages if needed
        ]);
      };
    };

    packageDefinitions = {
      # Main package
      nixCats = { pkgs, ... }: {
        settings = {
          wrapRc = true;
          configDirName = "nixCats-nvim";
          aliases = [ "vim" "nvim" ];
          hosts.python3.enable = true;
          hosts.node.enable = true;
        };
        
        categories = {
          # Enable all categories for full config
          core = true;
          ui = true;
          completion = true;
          lsp = true;
          treesitter = true;
          editor = true;
          ai = true;
          tools = true;
          testing = true;
          python = true;
          
          # LSP categories
          general = true;
          go = true;
          web = true;
          nix = true;
          docker = true;
          json = true;
          format = true;
        };
      };
      
      # Development package with live reloading
      nixCats-dev = { pkgs, ... }: {
        settings = {
          wrapRc = false;  # Live reload during development
          configDirName = "nixCats-nvim";
          aliases = [ "nvim-dev" ];
          hosts.python3.enable = true;
          hosts.node.enable = true;
        };
        
        categories = {
          # Same categories as main package
          core = true;
          ui = true;
          completion = true;
          lsp = true;
          treesitter = true;
          editor = true;
          ai = true;
          tools = true;
          testing = true;
          python = true;
          
          general = true;
          go = true;
          web = true;
          nix = true;
          docker = true;
          json = true;
          format = true;
        };
      };
      
      # Minimal package
      nixCats-minimal = { pkgs, ... }: {
        settings = {
          wrapRc = true;
          configDirName = "nixCats-nvim";
          aliases = [ "nvim-minimal" ];
        };
        
        categories = {
          # Only essential categories
          core = true;
          ui = true;
          completion = true;
          lsp = true;
          treesitter = true;
          
          general = true;
          nix = true;
        };
      };
    };

    defaultPackageName = "nixCats";
  in
  forEachSystem (system: let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit nixpkgs system dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions;
    
    defaultPackage = nixCatsBuilder defaultPackageName;
    pkgs = import nixpkgs { inherit system; };
  in {
    packages = utils.mkAllWithDefault defaultPackage;
    
    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ defaultPackage ];
        shellHook = ''
          echo "nixCats neovim development shell"
          echo "Available packages: nixCats, nixCats-dev, nixCats-minimal"
        '';
      };
    };
  }) // {
    nixosModules.default = utils.mkNixosModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
    
    homeModules.default = utils.mkHomeModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
    
    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions defaultPackageName;
    
    inherit utils;
    inherit (utils) templates;
  };
}
