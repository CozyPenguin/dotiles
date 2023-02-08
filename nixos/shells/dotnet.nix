{ pkgs, lib, ... }:
pkgs.mkShell {
  name = ".NET development";
  packages = with pkgs; [
    dotnet-sdk
  ];
}
