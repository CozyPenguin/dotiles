{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    fenix = {
      url = github:nix-community/fenix;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dottor = {
      url = github:CozyPenguin/dottor;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fenix.follows = "fenix";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, fenix, dottor, ... }:
    let
      inherit (lib.my) mapToAttrSet mapToList mapToFlatSet mapHosts;
      inherit (lib) id;
      inherit (builtins) map listToAttrs;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            my = self.packages."${system}";
          })
          dottor.overlay
          fenix.overlays.default
        ];
      };

      # thx hlissner/dotfiles
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;

      nixosModules = mapToAttrSet ./modules import;

      nixosConfigurations = mapHosts ./hosts {};

    } // (flake-utils.lib.eachDefaultSystem (system: {
      packages = mapToFlatSet ./packages (p: pkgs.callPackage p {});

      devShells = mapToFlatSet ./shells (s: pkgs.callPackage s {});
    }));
}
