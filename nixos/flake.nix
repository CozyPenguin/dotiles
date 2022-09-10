{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    dottor = {
      url = github:CozyPenguin/dottor;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, dottor, ... }:
    let
      inherit (lib.my) mapToAttrSet mapToList mapToFlatSet;
      inherit (lib) id;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            my = self.packages."${system}";
          })
          dottor.overlay
        ];
      };

      # thx hlissner/dotfiles
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;

      nixosModules = mapToAttrSet ./modules import;

      nixosConfigurations."carl-schierig" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs inputs lib; };
        modules = [
          ./configuration.nix 
        ] ++ (mapToList ./modules id);
      };

    } // (flake-utils.lib.eachDefaultSystem (system: {
      packages = mapToFlatSet ./packages (p: pkgs.callPackage p {});

      devShells = mapToFlatSet ./shells (s: pkgs.callPackage s {});
    }));
}
