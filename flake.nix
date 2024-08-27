{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    # Tricked out nvim
    pwnvim.url = "github:zmre/pwnvim";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    pwnvim,
    ...
  }: let
    mkHome = username: modules: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        extraSpecialArgs = {inherit inputs pwnvim username;};
        users."${username}".imports = modules;
      };
    };
  in {
    darwinConfigurations = let
      username = "franrubio";
    in {
        K032-3 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          (mkHome username [
            ./modules/home-manager
          ])
        ];
      };
    };
  };
}

