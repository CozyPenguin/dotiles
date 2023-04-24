{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = github:nix-community/fenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dottor = {
      url = github:cschierig/dottor;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fenix.follows = "fenix";
      inputs.flake-utils.follows = "flake-utils";
    };
    comma = {
      url = github:nix-community/comma;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };
    nix-index-database = {
      url = github:Mic92/nix-index-database;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, home-manager, fenix, dottor, comma, nix-index-database, ... }:
    let
      inherit (lib.my) mapToAttrSet mapToList mapToFlatSet mapHosts mapHome;
      inherit (lib) id;
      inherit (builtins) map listToAttrs;

      system = "x86_64-linux";
      stateVersion = "22.11";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            my = self.packages."${system}";
          })
          dottor.overlay
          comma.overlays.default
          fenix.overlays.default
        ];
      };

      # thx hlissner/dotfiles
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;

      nixosModules = mapToAttrSet ./modules import;

      nixosConfigurations = mapHosts ./hosts { 
        inherit system stateVersion;
        modules = [
          home-manager.nixosModules.home-manager
      ];};

      homeConfigurations = mapHome ./home {
        inherit system stateVersion;
        modules = [
          nix-index-database.hmModules.nix-index
        ];
      };
    } // (flake-utils.lib.eachDefaultSystem (system: {
      packages = mapToFlatSet ./packages (p: pkgs.callPackage p {});

      devShells = mapToFlatSet ./shells (s: pkgs.callPackage s {});
    }));
}
