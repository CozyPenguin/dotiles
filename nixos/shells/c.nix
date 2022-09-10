{ pkgs, lib, ... }:
pkgs.mkShell {
  name = "C/C++ development";
  packages = with pkgs; [
    gcc
    glibc
  ];
}
