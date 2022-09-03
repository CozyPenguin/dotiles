{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
  };
  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      inherit (lib.my) mapModulesRec listModulesRec;
      inherit (lib) id nameValuePair removeSuffix;
      inherit (builtins) listToAttrs;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config = prev.config;
            };
            my = self.packages."${system}";
          })
        ];
      };

      # thx hlissner/dotfiles
      lib = nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });
    in {
      lib = lib.my;

      packages."${system}" = listToAttrs (listModulesRec ./packages (p: nameValuePair (removeSuffix ".nix" (baseNameOf p)) (pkgs.callPackage p {})));

      nixosModules = mapModulesRec ./modules import;

      nixosConfigurations."carl-schierig" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgs inputs lib; };
        modules = [
          ./configuration.nix 
          ./lango
        ] ++ (listModulesRec ./modules id);
      };
    };
}
