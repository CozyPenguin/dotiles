{ pkgs, lib, ... }:
pkgs.mkShell {
  name = "Haskell development";
  packages = with pkgs; [
    (haskellPackages.ghcWithPackages (pkgs: with pkgs; [
      stack
    ]))
  ];
}
