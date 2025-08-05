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
        ];
        go = with pkgs; [
          gopls
          gotools
          go-tools
          delve
        ];
        python = with pkgs; [
          basedpyright
          ruff
        ];
        nix = with pkgs; [
          lua-language-server
          stylua
          nixd
        ];
        json = with pkgs; [
          nodePackages.jsonlint
        ];
        docker = with pkgs; [
          dockerfile-language-server-nodejs
          docker-compose-language-service
        ];
        templ = with pkgs; [
          templ
        ];
      };

      startupPlugins = {
        general = with pkgs.vimPlugins; {
          always = [
            lze
            plenary-nvim
            nvim-web-devicons
            guess-indent-nvim
          ];
        };
      };

      optionalPlugins = {
        # These will be loaded via lze
        ui = with pkgs.vimPlugins; [
          snacks-nvim
          lualine-nvim
          kanagawa-nvim
          lackluster-nvim
          noice-nvim
          nui-nvim
          nvim-notify
          nvim-navic
          marks-nvim
          # close-buffers-nvim  # Not available in nixpkgs
        ];
        git = with pkgs.vimPlugins; [
          gitsigns-nvim
          diffview-nvim
        ];
        editor = with pkgs.vimPlugins; [
          flash-nvim
          treesj
          undotree
          grug-far-nvim
          trouble-nvim
        ];
        copilot = with pkgs.vimPlugins; [
          copilot-lua
          blink-cmp
          CopilotChat-nvim
          copilot-vim
        ];
        completion = with pkgs.vimPlugins; [
          blink-cmp
          luasnip
          lazydev-nvim
        ];
        lsp = with pkgs.vimPlugins; [
          nvim-lspconfig
          fidget-nvim
          mason-nvim
          mason-lspconfig-nvim
          mason-tool-installer-nvim
          SchemaStore-nvim
        ];
        treesitter = with pkgs.vimPlugins; [
          nvim-treesitter.withAllGrammars
          nvim-treesitter-textobjects
        ];
        format = with pkgs.vimPlugins; [
          conform-nvim
        ];
        debug = with pkgs.vimPlugins; [
          nvim-dap
          nvim-dap-ui
          nvim-dap-go
          nvim-nio
          mason-nvim-dap-nvim
        ];
        testing = with pkgs.vimPlugins; [
          # neotest  # Build issues
          # neotest-python
        ];
        python = with pkgs.vimPlugins; [
          # pymple-nvim  # Not available in nixpkgs
          # python-copy-reference-vim  # Not available in nixpkgs
          vim-python-pep8-indent
        ];
        utils = with pkgs.vimPlugins; [
          dial-nvim
          harpoon2
          persistence-nvim
          # screenkey-nvim  # Not available in nixpkgs
          vim-tmux-navigator
        ];
        fold = with pkgs.vimPlugins; [
          nvim-ufo
          promise-async
          statuscol-nvim
        ];
        overseer = with pkgs.vimPlugins; [
          # overseer-nvim  # Depends on neotest which has build issues
        ];
        neo_tree = with pkgs.vimPlugins; [
          neo-tree-nvim
        ];
        mini = with pkgs.vimPlugins; [
          mini-nvim
        ];
        which_key = with pkgs.vimPlugins; [
          which-key-nvim
        ];
        todo_comments = with pkgs.vimPlugins; [
          todo-comments-nvim
        ];
      };

      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };

      environmentVariables = {
        test = {
          default = {
            CATTESTVARDEFAULT = "It worked!";
          };
        };
      };

      extraWrapperArgs = {
        test = [
          '' --set CATTESTVAR2 "It worked again!"''
        ];
      };

      python3.libraries = {
        test = (_:[]);
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
          ui = true;
          git = true;
          editor = true;
          copilot = true;
          completion = true;
          lsp = true;
          treesitter = true;
          format = true;
          debug = true;
          testing = true;
          python = true;
          utils = true;
          fold = true;
          overseer = true;
          neo_tree = true;
          mini = true;
          which_key = true;
          todo_comments = true;
          go = true;
          nix = true;
          json = true;
          docker = true;
          templ = true;
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
