{ pkgs, lib, ... }:

pkgs.mkShell {
  name = "Rust development";
  packages = with pkgs; [
    (pkgs.fenix.complete.withComponents [
      "cargo"
      "rust-src"
      "rustc"
      "rustfmt"
      "clippy"
    ])
  ];
}
