{ config, lib, pkgs, ... }:

with lib;
with lib.my;

let
  cfg = config.module.shells.direnv;
in {
  options.modules.shells = {
    direnv = {
      enable = mkEnableOption "direnv";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
        direnv
        (nix-direnv.override {
          enableFlakes = true;
        })];

    environment.pathsToLink = [
      "/share/nix-direnv"
    ];
  };
}
