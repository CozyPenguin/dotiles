{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    dottor = {
      url = github:CozyPenguin/dottor;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ { self, nixpkgs, dottor, ... }:
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

      packages."${system}" = mapToFlatSet ./packages (p: pkgs.callPackage p {});

      nixosModules = mapToAttrSet ./modules import;

      nixosConfigurations."carl-schierig" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs inputs lib; };
        modules = [
          ./configuration.nix 
          ./lango
        ] ++ (mapToList ./modules id);
      };
    };
}
