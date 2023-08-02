{ pkgs, lib, ... }:
pkgs.mkShell {
  name = "C/C++ development";
  packages = with pkgs; [
    clang
    clang-tools
    gdb
    ccls
  ];
}
