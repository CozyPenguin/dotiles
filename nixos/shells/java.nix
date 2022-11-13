{ pkgs, lib, ... }:
pkgs.mkShell {
  name = "Java development";
  packages = with pkgs; [
    jdk
    checkstyle
  ];
}
