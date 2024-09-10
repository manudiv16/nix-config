{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    systems,
    ...
  }: let
    forEachSystem = f:
      nixpkgs.lib.genAttrs (import systems)
      (system: f {pkgs = import nixpkgs {inherit system;};});
    mkHome = username: modules: {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        extraSpecialArgs = {inherit inputs ;};
        users."${username}".imports = modules;
      };
    };
  in {
    devShells = forEachSystem ({pkgs}: {
      default =
        pkgs.mkShellNoCC {packages = with pkgs; [opentofu gum nixfmt];};
    });
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
          (mkHome username [./modules/home-manager])
        ];
      };
    };
  };
}
