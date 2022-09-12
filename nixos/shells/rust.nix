{ pkgs, lib, ... }:

pkgs.mkShell {
  name = "Rust development";
  packages = with pkgs; [
    cargo
    rustc
  ];
}
