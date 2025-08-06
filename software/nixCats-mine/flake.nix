{
  description = "A Lua-natic's neovim flake, with extra cats! nixCats!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
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
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          universal-ctags
          ripgrep
          fd
          lazygit
          gopls
          gotools
          go-tools
          delve
          basedpyright
          ruff
          lua-language-server
          stylua
          nixd
          nodePackages.jsonlint
          dockerfile-language-server-nodejs
          docker-compose-language-service
          templ
        ];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          lze
          lzextras
          plenary-nvim
          nvim-web-devicons
          guess-indent-nvim
          snacks-nvim
          nui-nvim
          neo-tree-nvim
        ];
      };

      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          # UI plugins
          lualine-nvim
          kanagawa-nvim
          lackluster-nvim
          noice-nvim
          nvim-notify
          nvim-navic
          marks-nvim
          which-key-nvim

          # Git plugins
          gitsigns-nvim
          diffview-nvim

          # Editor plugins
          flash-nvim
          treesj
          undotree
          grug-far-nvim
          trouble-nvim

          # Copilot plugins
          copilot-lua
          blink-cmp
          CopilotChat-nvim
          copilot-vim

          # Completion plugins
          luasnip
          lazydev-nvim

          # LSP plugins
          nvim-lspconfig
          fidget-nvim
          mason-nvim
          mason-lspconfig-nvim
          mason-tool-installer-nvim
          SchemaStore-nvim

          # Treesitter plugins
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects

          # Format plugins
          conform-nvim

          # Debug plugins
          nvim-dap
          nvim-dap-ui
          nvim-dap-go
          nvim-nio
          mason-nvim-dap-nvim

          # Python plugins
          vim-python-pep8-indent

          # Utility plugins
          dial-nvim
          harpoon2
          persistence-nvim
          vim-tmux-navigator

          # Fold plugins
          nvim-ufo
          promise-async
          statuscol-nvim

          # Mini plugins
          mini-nvim

          # Todo comments
          todo-comments-nvim
        ];
      };

      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };

      extraWrapperArgs = {
        general = [
          '' --set CATTESTVAR2 "It worked again!"''
        ];
      };

      python3.libraries = {
        general = (_:[]);
      };

      extraLuaPackages = {
        general = [ (_:[]) ];
      };

      extraCats = {
        # Enable default subcategories when parent is enabled
      };
    };

    packageDefinitions = {
      nixCats = { pkgs, name, ... }@misc: {
        settings = {
          suffix-path = true;
          suffix-LD = true;
          aliases = [ "vim" "nvim" ];
          wrapRc = true;
          configDirName = "nixCats-mine";
          hosts.python3.enable = true;
          hosts.node.enable = true;
        };
        categories = {
          general = true;
        };
        extra = {
          # Extra configuration can go here
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
        inputsFrom = [ ];
        shellHook = ''
        '';
      };
    };

  }) // (let
    nixosModule = utils.mkNixosModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
    homeModule = utils.mkHomeModules {
      moduleNamespace = [ defaultPackageName ];
      inherit defaultPackageName dependencyOverlays luaPath
        categoryDefinitions packageDefinitions extra_pkg_config nixpkgs;
    };
  in {
    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays extra_pkg_config;
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = nixosModule;
    homeModules.default = homeModule;

    inherit utils nixosModule homeModule;
    inherit (utils) templates;
  });
}
