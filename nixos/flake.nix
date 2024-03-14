{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;
    devshell = { 
      url = github:numtide/devshell;
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
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
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs = inputs @ { self, nixpkgs, flake-utils, home-manager, fenix, dottor, nix-vscode-extensions, devshell, ... }:
    let
      inherit (lib.my) mapToAttrSet mapToList mapToFlatSet mapHosts mapHome;
      inherit (lib) id;
      inherit (builtins) map listToAttrs getAttr;

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
          fenix.overlays.default
          nix-vscode-extensions.overlays.default
          devshell.overlays.default
        ];
      };

      stdenv = pkgs.stdenv;

      # thx hlissner/dotfiles
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in
    {
      lib = lib.my;

      nixosModules = mapToAttrSet ./modules import;

      nixosConfigurations = mapHosts ./hosts {
        inherit system stateVersion;
        modules = [
          home-manager.nixosModules.home-manager
          {
            system.extraDependencies = mapToList ./shells (s: pkgs.callPackage s { inherit lib; });
          }
        ];
      };

      homeConfigurations = mapHome ./home {
        inherit system stateVersion;
        modules = [
        ];
      };
    } // (flake-utils.lib.eachDefaultSystem (system: let 
        shells = mapToFlatSet ./shells (s: pkgs.callPackage s { inherit lib; });
      in {
      devShells = shells;

      packages = mapToFlatSet ./packages (p: pkgs.callPackage p { }) // shells;
      }));
}
