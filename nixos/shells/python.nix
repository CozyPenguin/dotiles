{ pkgs, lib, ... }:
pkgs.mkShell {
  name = "Python development";
  packages = with pkgs; [
    python3
  ];
}
