{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixCats-mine = {
      url = "path:./software/nix.nvim/";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";

    };
    sherlock.url = "github:Skxxtz/sherlock";
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swww.url = "github:LGFae/swww";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    agenix.inputs.darwin.follows = "";

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixCats-mine,
      agenix,
      ...
    }@inputs:
    {
      # replace 'joes-desktop' with your hostname here.
      nixosConfigurations.nixosy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs nixCats-mine; };
        modules = [
          ./configuration.nix
          agenix.nixosModules.default
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nixy = ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
