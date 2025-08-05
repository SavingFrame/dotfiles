{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixCats-mine = {
      url = "path:./software/nixCats-mine";
    };
    opencode = {
      url = "github:sst/opencode/v0.3.85";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, nixCats-mine, opencode,  ... }@inputs: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixosy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs nixCats-mine opencode; };
      modules = [
      ./configuration.nix 

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.nixy = ./home.nix;
        home-manager.extraSpecialArgs = { inherit inputs opencode; };

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
      {
        nixpkgs.overlays = [
          (final: prev: {
            opencode = nixpkgs.legacyPackages.${prev.system}.opencode.overrideAttrs (old: rec {
                version = "0.3.128";
                 # `opencode` is a flake input
                 src = opencode;
                 node_modules = old.node_modules.overrideAttrs (nmOld: {
                   outputHash = "sha256-ZtZvS0jF2YpkDeCdP2y1qX4fJVMq8BBq6EFwqvDEfdc=";
                 });
                 tui = old.tui.overrideAttrs (tuiOld: {
                   # these two lines below are important
                   src = src;
                   modRoot = "packages/tui";
                   vendorHash = "sha256-+j8+TjTzd7AH9Si9tS7noTpPcG1lz9j+tmxUTrPcThw=";
                 });
            });
          })
        ];
      }
      ];
    };
  };
}
